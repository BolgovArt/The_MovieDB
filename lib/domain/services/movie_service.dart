import 'package:vk/configuration/configutarion.dart';
import 'package:vk/domain/api_client/account_api_client.dart';
import 'package:vk/domain/api_client/movie_api_client.dart';
import 'package:vk/domain/data_providers/session_data_provider.dart';
import 'package:vk/domain/entity/popular_movie_responce.dart';
import 'package:vk/domain/local_entity/movie_details_local.dart';
import 'package:vk/widgets/movie_details/film_page_model.dart';
import 'package:vk/widgets/movie_list/movie_list_model.dart';

class MovieService implements MoviePageModelMovieProvider, MovieListModelMoviesProvider{
  final MovieApiClient movieApiClient;
  final SessionDataProvider sessionDataProvider;
  final AccountApiClient accountApiClient;

  const MovieService({
    required this.movieApiClient,
    required this.sessionDataProvider,
    required this.accountApiClient,
  });

  @override
  Future<PopularMovieResponce> popularFilms(int page, String locale) async {
    return movieApiClient.popularFilms(page, locale, Configutarion.apiKey, Configutarion.unsplashUrl);
  } 
  
  @override
  Future<PopularMovieResponce> searchFilms(int page, String locale, String query) async => 
    movieApiClient.searchFilms(page, locale, query, Configutarion.apiKey, Configutarion.unsplashUrl); 

  // Сервис тут передает данные файла конфигурации в хранилище. До этого в файле сервиса апи клиента была зашита конфига,
  // что не очень грамотно. Хранилище должно быть независимым.
  // Сейчас методы movieDetails и isFavorite все ещё не обработаны.


  @override
  Future<MovieDetailsLocal> loadDetails({
      required int movieId, 
      required String locale
    }) async {
      final movieDetails = await movieApiClient.movieDetails(movieId, locale);
      final sessionId = await sessionDataProvider.getSessionId();
      var isFavorite = false;
      if (sessionId != null ) {
        isFavorite = await movieApiClient.isFavorite(movieId, sessionId);
      }
      return MovieDetailsLocal(details: movieDetails, isFavorite: isFavorite);
    }


    @override
      Future<void> updateFavorite({
        required int movieId,
        required bool isFavorite,
      }) async { 
    final sessionId = await sessionDataProvider.getSessionId(); 
    final accountId = await sessionDataProvider.getAccountId();

    if (sessionId == null || accountId == null) return;
    await accountApiClient.markAsFavorite(
      accountId: accountId, 
      sessionId: sessionId, 
      mediaType: MediaType.movie, 
      mediaId: movieId, 
      isFavorite: isFavorite, 
    );
  }
}
