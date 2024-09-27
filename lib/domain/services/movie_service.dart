import 'package:vk/domain/api_client/movie_api_client.dart';
import 'package:vk/domain/entity/popular_movie_responce.dart';
import 'package:vk/configuration/configutarion.dart';

class MovieService {
  final _movieApiClient = MovieApiClient();

  Future<PopularMovieResponce> popularFilms(int page, String locale) async {
    return _movieApiClient.popularFilms(page, locale, Configutarion.apiKey, Configutarion.unsplashUrl);
  } 
  
  Future<PopularMovieResponce> searchFilms(int page, String locale, String query) async => 
    _movieApiClient.searchFilms(page, locale, query, Configutarion.apiKey, Configutarion.unsplashUrl); 

  // Сервис тут передает данные файла конфигурации в хранилище. До этого в файле сервиса апи клиента была зашита конфига,
  // что не очень грамотно. Хранилище должно быть независимым.
  // Сейчас методы movieDetails и isFavorite все ещё не обработаны.
}