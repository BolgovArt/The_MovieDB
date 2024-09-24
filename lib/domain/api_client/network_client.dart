import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vk/domain/api_client/api_client_exception.dart';

class NetworkClient {

  // // ?
  // final _client = HttpClient();
  // // ?

  

  Future<T> get<T>(
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
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } 
    catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }


  Future<T> post<T>(
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
        headers: headersParameters, body: bodyParameters
      );
 
      final dynamic json = jsonDecode(response.body);
      _validateResponce(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  void _validateResponce(http.Response response, dynamic json) {
    if (response.statusCode == 401) {
      final dynamic status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientException(ApiClientExceptionType.auth);
      } else if (code == 3) {
        throw ApiClientException(ApiClientExceptionType.sessionExpired);
      } 
      else {
        throw ApiClientException(ApiClientExceptionType.other);
      }
    }
  }
  
}