import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vk/domain/entity/movie_details.dart';
import 'package:vk/domain/entity/popular_movie_responce.dart';

enum ApiClientExceptionType { Network, Auth, Other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  static const _apiKey = '7a3703e15f9ef6c0f3397cc7158231bc';
  static const String unsplashUrl = 'api.themoviedb.org';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';

  static String imageUrl(String path) => _imageUrl + path;

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final token = await _getToken();
    // print('username: $username');
    // print('password: $password');
    final validateToken = await _validateUser(
        username: username, password: password, requestToken: token);
    final sessionId = await _makeSession(requestToken: validateToken);
    return sessionId;
  }

  Future<T> _get<T>(
    String unsplashUrl,
    String urlPath,
    T Function(dynamic json) parser,
    Map<String, dynamic>? parameters,
  ) async {
    final url = Uri.https(unsplashUrl, urlPath, parameters);
    try {
      final response = await http.get(url);
      final dynamic json = jsonDecode(response.body);
      _validateResponce(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } 
    // catch (_) {
    //   throw ApiClientException(ApiClientExceptionType.Other);
    // }
  }

  Future<T> _post<T>(
    String unsplashUrl,
    String urlPath,
    T Function(dynamic json) parser,
    Map<String, dynamic>? urlParameters,
    Map<String, String> headersParameters,
    String bodyParameters,
  ) async {
    try {
      final url = Uri.https(unsplashUrl, urlPath, urlParameters);
      final response = await http.post(url,
          headers: headersParameters, body: bodyParameters);
      final dynamic json = jsonDecode(response.body);
      _validateResponce(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<String> _getToken() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _get(
      unsplashUrl,
      '/3/authentication/token/new',
      parser,
      <String, dynamic>{'api_key': _apiKey},
    );
    return result;
  }

  Future<String> _validateUser(
      {required String username,
      required String password,
      required String requestToken}) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final headersParameters = {
      'Content-Type': ContentType.json.mimeType,
    };
    final bodyParameters = jsonEncode({
      "username": username,
      "password": password,
      "request_token": requestToken,
    });

    final result = _post(
        unsplashUrl,
        '/3/authentication/token/validate_with_login',
        parser,
        {'api_key': _apiKey},
        headersParameters,
        bodyParameters);
    return result;
  }

  Future<String> _makeSession({required String requestToken}) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap['session_id'] as String;
      return sessionId;
    }

    final headersParameters = {
      'Content-Type': ContentType.json.mimeType,
    };
    final bodyParameters = jsonEncode({
      "request_token": requestToken,
    });

    final result = _post(unsplashUrl, '/3/authentication/session/new', parser,
        {'api_key': _apiKey}, headersParameters, bodyParameters);
    return result;
  }

  void _validateResponce(http.Response response, dynamic json) {
    if (response.statusCode == 401) {
      final dynamic status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientException(ApiClientExceptionType.Auth);
      } else {
        throw ApiClientException(ApiClientExceptionType.Other);
      }
    }
  }



  Future<PopularMovieResponce> popularFilms(int page, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponce.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      unsplashUrl,
      '/3/movie/popular',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
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

    final result = _get(
      unsplashUrl,
      '/3/search/movie',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
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

    final result = _get(
      unsplashUrl,
      '/3/movie/$movieId',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language': locale,
        'append_to_response': 'credits',
        },
    );
    return result;
  }


}
