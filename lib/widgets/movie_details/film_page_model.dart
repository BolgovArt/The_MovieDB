import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vk/domain/api_client/account_api_client.dart';
import 'package:vk/domain/api_client/movie_api_client.dart';
import 'package:vk/domain/api_client/api_client_exception.dart';
import 'package:vk/domain/data_providers/session_data_provider.dart';
import 'package:vk/domain/entity/movie_details.dart';
import 'package:vk/domain/services/auth_service.dart';
import 'package:vk/ui/navigation/main_navigation.dart';

class MoviePageModel extends ChangeNotifier { 
  final _authService = AuthService();
  final _sessionDataProvider = SessionDataProvider();
  final _movieApiClient = MovieApiClient();
  final _accountApiClient = AccountApiClient();

  final int movieId; 
  MovieDetails? _movieDetails;
  bool _isFavorite = false;
  String _locale = '';
  late DateFormat _dateFormat;
  // Future<void>? Function()? onSessionExpired;

  MovieDetails? get movieDetails => _movieDetails;
  bool? get isFavorite => _isFavorite;

  MoviePageModel(this.movieId);

  String stringFromDate(DateTime? date) => date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return; 
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await loadDetails(context);
  }

  Future<void> loadDetails(BuildContext context) async {
    try {
      _movieDetails = await _movieApiClient.movieDetails(movieId, _locale);
      final sessionId = await _sessionDataProvider.getSessionId();
      if (sessionId != null ) {
        _isFavorite = await _movieApiClient.isFavorite(movieId, sessionId);
      }
      notifyListeners();
    } on ApiClientException catch (e) {
    _handleApiClientException(e, context);
    }
  }


  Future<void> toggleFavorite(BuildContext context) async { 
    final sessionId = await _sessionDataProvider.getSessionId(); 
    final accountId = await _sessionDataProvider.getAccountId();

    if (sessionId == null || accountId == null) return;

    _isFavorite = !_isFavorite;
    notifyListeners();
    try {
      await _accountApiClient.markAsFavorite(
        accountId: accountId, 
        sessionId: sessionId, 
        mediaType: MediaType.movie, 
        mediaId: movieId, 
        isFavorite: _isFavorite, 
      );
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  void _handleApiClientException(ApiClientException exeption, BuildContext context){
    switch (exeption.type) {
        case ApiClientExceptionType.sessionExpired:
          _authService.logout();
          MainNavigation.resetNavigation(context);
          break;
        default:
          print(exeption);
      }
  }

}
