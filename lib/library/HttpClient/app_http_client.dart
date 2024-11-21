// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';

// abstract class AppHttpClient {
//   Future<Response> get(url);
//   Future<Response> post(url);
// }

// class AppHttpClientDefault implements AppHttpClient{
//   final _client = HttpClient();
  
  
//   @override
//   Future<Response> get(url) => http.get(url);
  
//   @override
//   Future<Response> post(url) => http.post(url);
// }

// короче тут код должен быть для встроенного пакета http, тк в приложении в сервисе я его не юзал, то и не описывал тут и не внедрял в di container (NetworkClient makeNetworkClient() => NetworkClientDefaults();)