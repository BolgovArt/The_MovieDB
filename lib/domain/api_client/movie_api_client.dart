import 'package:vk/configuration/configutarion.dart';
import 'package:vk/domain/api_client/network_client.dart';
import 'package:vk/domain/entity/movie_details.dart';
import 'package:vk/domain/entity/popular_movie_responce.dart';


class MovieApiClient {
  final _networkClient = NetworkClient();

  Future<PopularMovieResponce> popularFilms(int page, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponce.fromJson(jsonMap);
      return response;
    }

    final result = _networkClient.get(
      Configutarion.unsplashUrl,
      '/3/movie/popular',
      parser,
      <String, dynamic>{
        'api_key': Configutarion.apiKey,
        'page': page.toString(),
        'language': locale,
        },
    );
    return result;
  }


  Future<PopularMovieResponce> searchFilms(int page, String locale, String query) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponce.fromJson(jsonMap);
      return response;
    }

    final result = _networkClient.get(
      Configutarion.unsplashUrl,
      '/3/search/movie',
      parser,
      <String, dynamic>{
        'api_key': Configutarion.apiKey,
        'page': page.toString(),
        'language': locale,
        'query': query,
        'include_adult': true.toString(),
        },
    );
    return result;
  }


Future<MovieDetails> movieDetails(
  int movieId, 
  String locale,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetails.fromJson(jsonMap);
      return response;
    }

    final result = _networkClient.get(
      Configutarion.unsplashUrl,
      '/3/movie/$movieId',
      parser,
      <String, dynamic>{
        'api_key': Configutarion.apiKey,
        'language': locale,
        'append_to_response': 'credits,videos',
        },
    );
    return result;
  }


Future<bool> isFavorite(
  int movieId, 
  String sessionId,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['favorite'] as bool;
      return result;
    }

    final result = _networkClient.get(
      Configutarion.unsplashUrl,
      '/3/movie/$movieId/account_states',
      parser,
      <String, dynamic>{
        'api_key': Configutarion.apiKey,
        'session_id': sessionId,
        },
    );
    return result;
  }

}
