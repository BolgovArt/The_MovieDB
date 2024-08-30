import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vk/domain/api_client/api_client.dart';
import 'package:vk/domain/data_providers/session_data_provider.dart';
import 'package:vk/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  // final logInTextController = TextEditingController(text: 'admin');
  // final passwordTextController = TextEditingController(text: 'admin');

  final logInTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  String? _errorMessage = null;
  String? get errorMessage => _errorMessage;

  Future<void> authorization(BuildContext context) async {
    final login = logInTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполните логин и пароль';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    try {
      sessionId = await _apiClient.auth(username: login, password: password);
      // _isAuthProgress = false;
      // notifyListeners();
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.Network:
          _errorMessage =
              'Сервер недоступен. Проверьте подключение к интернету.';
        case ApiClientExceptionType.Auth:
          _errorMessage = 'Неверный логин/пароль';
        case ApiClientExceptionType.Other:
          _errorMessage = 'Произошла ошибка, попробуйте ещё раз.';
      }
    }
    _isAuthProgress = false;
    if (_errorMessage != null || sessionId == null) {
      // if (_errorMessage != null) {
      notifyListeners();
      return;
    }
    // if (sessionId == null) {
    //   _errorMessage = 'че-то с серверной частью беда';
    //   notifyListeners();
    //   return;
    // }
    await _sessionDataProvider.setSessionId(sessionId);
    unawaited(Navigator.of(context)
        .pushReplacementNamed(MainNavigationRouteNames.mainScreen));
  }
}
