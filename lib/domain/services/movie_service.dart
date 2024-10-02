import 'package:vk/domain/api_client/account_api_client.dart';
import 'package:vk/domain/api_client/movie_api_client.dart';
import 'package:vk/domain/data_providers/session_data_provider.dart';
import 'package:vk/domain/entity/popular_movie_responce.dart';
import 'package:vk/configuration/configutarion.dart';
import 'package:vk/domain/local_entity/movie_details_local.dart';

class MovieService {
  final _movieApiClient = MovieApiClient();
  final _sessionDataProvider = SessionDataProvider();
  final _accountApiClient = AccountApiClient();

  Future<PopularMovieResponce> popularFilms(int page, String locale) async {
    return _movieApiClient.popularFilms(page, locale, Configutarion.apiKey, Configutarion.unsplashUrl);
  } 
  
  Future<PopularMovieResponce> searchFilms(int page, String locale, String query) async => 
    _movieApiClient.searchFilms(page, locale, query, Configutarion.apiKey, Configutarion.unsplashUrl); 

  // Сервис тут передает данные файла конфигурации в хранилище. До этого в файле сервиса апи клиента была зашита конфига,
  // что не очень грамотно. Хранилище должно быть независимым.
  // Сейчас методы movieDetails и isFavorite все ещё не обработаны.


  Future<MovieDetailsLocal> loadDetails({
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


    Future<void> updateFavorite({
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