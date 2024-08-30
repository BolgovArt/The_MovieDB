import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

enum ApiClientExceptionType { Network, Auth, Other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  static const _apiKey = '7a3703e15f9ef6c0f3397cc7158231bc';
  static const String unsplashUrl = 'api.themoviedb.org';

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final token = await _getToken();
    print('username: $username');
    print('password: $password');
    final validateToken = await _validateUser(
        username: username, password: password, requestToken: token);
    final sessionId = await _makeSession(requestToken: validateToken);
    return sessionId;
  }

  Future<T> _get<T>(
      String unsplashUrl, String urlPath, T Function(dynamic json) parser,
      [Map<String, dynamic>? parameters]) async {
    // const String urlPath = '/3/authentication/token/new';
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
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<String> _getToken() async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    };
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
    const String urlPath = '/3/authentication/token/validate_with_login';
    try {
      final url = Uri.https(unsplashUrl, urlPath, {'api_key': _apiKey});
      final response = await http.post(url,
          headers: {
            // 'Content-Type': 'application/json; charset=UTF-8', // одинаковые строчки
            'Content-Type': ContentType.json.mimeType, // одинаковые строчки
          },
          body: jsonEncode({
            "username": username,
            "password": password,
            "request_token": requestToken,
          }));
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      _validateResponce(response, json);
      final token = json['request_token'] as String;
      return token;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<String> _makeSession({required String requestToken}) async {
    try {
      const String urlPath = '/3/authentication/session/new';
      final url = Uri.https(unsplashUrl, urlPath, {'api_key': _apiKey});
      final response = await http.post(url,
          headers: {
            'Content-Type':
                'application/json; charset=UTF-8', // одинаковые строчки
            // 'Content-Type': ContentType.json.mimeType, // одинаковые строчки
          },
          body: jsonEncode({
            "request_token": requestToken,
          }));

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      _validateResponce(response, json);
      final sessionId = json['session_id'] as String;
      return sessionId;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
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
}
