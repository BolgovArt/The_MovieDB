import 'package:flutter/material.dart';
import 'package:vk/domain/data_providers/session_data_provider.dart';
import 'package:vk/ui/navigation/main_navigation.dart';

class MyAppModel {
  final _sessionDataProvider = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async { // при async await функции присваивается само значение Future, без async await присваивался бы сам объект Future, который делал бессмысленной его проверку на null
    final sessionId = await _sessionDataProvider.getSessionId();
    if (sessionId != null && sessionId.isNotEmpty) {
      _isAuth = true;
    }
  }

  Future<void> resetSession(context) async {
    await _sessionDataProvider.setSessionId(null);
    await _sessionDataProvider.setAccountId(null);
    await Navigator.of(context).pushNamedAndRemoveUntil(MainNavigationRouteNames.authorization, (route) => false);
  }
}