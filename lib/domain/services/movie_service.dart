import 'package:vk/domain/api_client/account_api_client.dart';
import 'package:vk/domain/api_client/movie_api_client.dart';
import 'package:vk/domain/data_providers/session_data_provider.dart';
import 'package:vk/domain/entity/popular_movie_responce.dart';
import 'package:vk/configuration/configuration.dart';
import 'package:vk/domain/local_entity/movie_details_local.dart';

// Воспользуемся блоком, а не кубитом, потому что нужна четкая последовательность действий - загрузка одной страницы не была поверх загрузки второй



class MovieService {
  final _movieApiClient = MovieApiClient();
  final _sessionDataProvider = SessionDataProvider();
  final _accountApiClient = AccountApiClient();

  Future<PopularMovieResponce> popularFilms(int page, String locale) async { // бесполезный метод, созданный лишь для соблюдения архитектуры
    return _movieApiClient.popularFilms(page, locale, Configuration.apiKey, Configuration.unsplashUrl);
  } 
  
  Future<PopularMovieResponce> searchFilms(int page, String locale, String query) async => // бесполезный метод, созданный лишь для соблюдения архитектуры
    _movieApiClient.searchFilms(page, locale, query, Configuration.apiKey, Configuration.unsplashUrl); 

  // Сервис тут передает данные файла конфигурации в хранилище. До этого в файле сервиса апи клиента была зашита конфига,
  // что не очень грамотно. Хранилище должно быть независимым.
  // Сейчас методы movieDetails и isFavorite все ещё не обработаны.


  Future<MovieDetailsLocal> loadDetails({ // тут агрегация реализована
      required int movieId, 
      required String locale
    }) async {
      final movieDetails = await _movieApiClient.movieDetails(movieId, locale);
      final sessionId = await _sessionDataProvider.getSessionId();
      var isFavorite = false;
      if (sessionId != null ) {
        isFavorite = await _movieApiClient.isFavorite(movieId, sessionId);
      }
      return MovieDetailsLocal(details: movieDetails, isFavorite: isFavorite);
    }


    Future<void> updateFavorite({ // тут тоже агрегация
        required int movieId,
        required bool isFavorite,
      }) async { 
    final sessionId = await _sessionDataProvider.getSessionId(); 
    final accountId = await _sessionDataProvider.getAccountId();

    if (sessionId == null || accountId == null) return;
    await _accountApiClient.markAsFavorite(
      accountId: accountId, 
      sessionId: sessionId, 
      mediaType: MediaType.movie, 
      mediaId: movieId, 
      isFavorite: isFavorite, 
    );
  }
}