import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vk/domain/api_client/api_client_exception.dart';
import 'package:vk/extentions/context_extention.dart';
import 'package:vk/ui/navigation/main_navigation_actions.dart';

abstract class AuthViewModelLoginProvider {
  Future<void> login(String login, String password);
}

class AuthViewModel extends ChangeNotifier {
  final MainNavigationActions mainNavigationActions;
  final AuthViewModelLoginProvider loginProvider;


  final logInTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  bool _isValid(String login, String password) => 
    login.isNotEmpty || password.isNotEmpty;

  Future<String?> _login(String login, String password, BuildContext context) async {
    try {
      await loginProvider.login(login, password);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return context.loc.auth_model_network_error;
        case ApiClientExceptionType.auth:
          return context.loc.auth_model_network_auth;
        case ApiClientExceptionType.other:
          return context.loc.auth_model_network_other;
        case ApiClientExceptionType.sessionExpired: 
          return context.loc.auth_model_network_sessionExpired;
      }
    } catch (e) {
      return 'sessionId или accountId = null';
    }
    return null;
  }

  String? _errorMessage = null;

  AuthViewModel({
    required this.mainNavigationActions,
    required this.loginProvider,
  });
  String? get errorMessage => _errorMessage;

  Future<void> authorization(BuildContext context) async {
    final login = logInTextController.text;
    final password = passwordTextController.text;

    if (!_isValid(login, password)) {
      _errorMessage = context.loc.attention_empty_fields;
      notifyListeners();
      return;
    }

    _updateState(null, true);
    // _errorMessage = null;
    // _isAuthProgress = true;
    // notifyListeners();

    _errorMessage = await _login(login, password, context);
      
    // _isAuthProgress = false;

    if (_errorMessage != null) {
      _updateState(_errorMessage, false);
      return;
    }
    mainNavigationActions.resetNavigation(context);
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
