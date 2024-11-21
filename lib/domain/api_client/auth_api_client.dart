import 'dart:convert';
import 'dart:io';

import 'package:vk/configuration/configutarion.dart';
import 'package:vk/domain/api_client/network_client.dart';

abstract class AuthApiClient {
  Future<String> auth({
    required String username,
    required String password,
  });
}

class AuthApiClientDefault implements AuthApiClient {
  final NetworkClient networkClient;
  const AuthApiClientDefault({
    required this.networkClient,
  });
  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final token = await _getToken();
    final validateToken = await _validateUser(
      username: username, password: password, requestToken: token);
    final sessionId = await _makeSession(requestToken: validateToken);
    return sessionId;
  }

  Future<String> _getToken() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = networkClient.get(
      Configutarion.unsplashUrl,
      '/3/authentication/token/new',
      parser,
      <String, dynamic>{'api_key': Configutarion.apiKey},
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

    final result = networkClient.post(
        Configutarion.unsplashUrl,
        '/3/authentication/token/validate_with_login',
        parser,
        {'api_key': Configutarion.apiKey},
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

    final result = networkClient.post(
        Configutarion.unsplashUrl,
        '/3/authentication/session/new',
        parser,
        {'api_key': Configutarion.apiKey},
        headersParameters,
        bodyParameters);
    return result;
  }
}
