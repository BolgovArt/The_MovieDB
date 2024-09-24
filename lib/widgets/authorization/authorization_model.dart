import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vk/domain/api_client/api_client.dart';
import 'package:vk/domain/services/auth_service.dart';
import 'package:vk/ui/navigation/main_navigation.dart';

class AuthViewModel extends ChangeNotifier {
  final _authService = AuthService();

  final logInTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  bool _isValid(String login, String password) => 
    login.isNotEmpty || password.isNotEmpty;

  Future<String?> _login(String login, String password) async {
    try {
      _authService.login(login, password);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.Network:
          return 'Сервер недоступен. Проверьте подключение к интернету.';
        case ApiClientExceptionType.Auth:
          return 'Неверный логин/пароль';
        case ApiClientExceptionType.Other:
          return 'Произошла ошибка, попробуйте ещё раз.';
        case ApiClientExceptionType.SessionExpired:
          return 'Ошибка сессии';
      }
    } catch (e) {
      return 'sessionId или accountId = null';
    }
    return null;
  }

  String? _errorMessage = null;
  String? get errorMessage => _errorMessage;

  Future<void> authorization(BuildContext context) async {
    final login = logInTextController.text;
    final password = passwordTextController.text;

    if (!_isValid(login, password)) {
      _errorMessage = 'Заполните логин и пароль';
      notifyListeners();
      return;
    }

    _updateState(null, true);
    // _errorMessage = null;
    // _isAuthProgress = true;
    // notifyListeners();

    _errorMessage = await _login(login, password);
      
    // _isAuthProgress = false;

    if (_errorMessage != null) {
      _updateState(_errorMessage, false);
    }
    MainNavigation.resetNavigation(context);
  }


  void _updateState(String? errorMessage, bool isAuthProgress) {
    if (_errorMessage == errorMessage && _isAuthProgress == isAuthProgress) {
      return;
    }
    _errorMessage = errorMessage;
    _isAuthProgress = isAuthProgress;
    notifyListeners();
  }
}
