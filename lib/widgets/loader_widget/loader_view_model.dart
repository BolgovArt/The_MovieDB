import 'package:flutter/material.dart';
import 'package:vk/domain/services/auth_service.dart';
import 'package:vk/ui/navigation/main_navigation.dart';

class LoaderViewModel {
  final BuildContext context;
  final _authService = AuthService();

  LoaderViewModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final isAuth = await _authService.isAuth();
    // if (_isAuth) {
    //   Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.mainScreen);
    // } else {
    //   Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.authorization);
    // }
    final nextScreen = isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.authorization;
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}