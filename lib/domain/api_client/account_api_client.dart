import 'dart:convert';
import 'dart:io';
import 'package:vk/configuration/configutarion.dart';
import 'package:vk/domain/api_client/network_client.dart';

enum MediaType { movie, tv }

extension MediaTypeAsString on MediaType {
  String asString() {
    switch(this) {
      case MediaType.movie: return 'movie';
      case MediaType.tv: return 'tv';
    }
  }
}

class AccountApiClient {
  final _networkClient = NetworkClient();
  Future<int> getAccountInfo(
  String sessionId,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['id'] as int;
      return result;
    }

    final result = _networkClient.get(
      Configutarion.unsplashUrl,
      '/3/account',
      parser,
      <String, dynamic>{
        'api_key': Configutarion.apiKey,
        'session_id': sessionId,
        },
    );
    return result;
  }

    Future<int> markAsFavorite({
    required int accountId, 
    required String sessionId, 
    required MediaType mediaType, 
    required int mediaId, 
    required bool isFavorite,
    }) async {
    parser(dynamic json) {
      // final jsonMap = json as Map<String, dynamic>;
      // final token = jsonMap['request_token'] as String;
      return 1; // !
    }

    final headersParameters = {
      'Content-Type': ContentType.json.mimeType,
    };
    final bodyParameters = jsonEncode({
      "media_type": mediaType.asString(),
      "media_id": mediaId,
      "favorite": isFavorite,
    });

    final result = _networkClient.post(
        Configutarion.unsplashUrl,
        '/3/account/$accountId/favorite',
        parser,
        <String, dynamic>{
          'api_key': Configutarion.apiKey,
          'session_id': sessionId,
          },
        headersParameters,
        bodyParameters,
        
    );
    return result;
  }
}