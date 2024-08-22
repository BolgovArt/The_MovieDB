import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;



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
    final validateToken = await _validateUser(username: username, password: password, requestToken: token);
    final sessionId = await _makeSession(requestToken: validateToken);
    return sessionId;
  }

  Future<String> _getToken() async {
    print('GET TOKEN START');
    const String urlPath = '/3/authentication/token/new';
    final url = Uri.https(unsplashUrl, urlPath, {'api_key': _apiKey});
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer 7a3703e15f9ef6c0f3397cc7158231bc',
        'accept': 'application/json'
      }
    ); 
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode != 200) {
      throw Exception('Failed to load token. Status code: ${response.statusCode}');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final token = json['request_token'] as String;
    print('token: $token');
    return token;
  }

  
  
  Future<String> _validateUser({
    required String username, 
    required String password, 
    required String requestToken
  }) async {
    print('in validation 1');
    const String urlPath = '/3/authentication/token/validate_with_login';
    final url = Uri.https(unsplashUrl, urlPath, {'api_key': _apiKey});
    final response = await http.post(
      url,
      headers: {
        // 'Content-Type': 'application/json; charset=UTF-8', // одинаковые строчки
        'Content-Type': ContentType.json.mimeType, // одинаковые строчки
      },
      body: jsonEncode({
        "username": username,
        "password": password,
        "request_token": requestToken,
      })
      );
    print('in validation 2');
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final token = json['request_token'] as String;
    return token;
  }

  Future<String> _makeSession({
      required String requestToken
      }) async {
    const String urlPath = '/3/authentication/session/new';
    final url = Uri.https(unsplashUrl, urlPath, {'api_key': _apiKey});
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8', // одинаковые строчки
        // 'Content-Type': ContentType.json.mimeType, // одинаковые строчки
      },
      body: jsonEncode({
        "request_token": requestToken,
      })
      );

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final sessionId = json['session_id'] as String;
    return sessionId;
  }

  
  }