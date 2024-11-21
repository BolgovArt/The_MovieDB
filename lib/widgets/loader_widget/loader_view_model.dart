import 'package:flutter/material.dart';
import 'package:vk/ui/navigation/main_navigation_route_names.dart';

abstract class LoaderViewModelAuthStatusProvider {
  Future<bool> isAuth();
}

class LoaderViewModel {
  final BuildContext context;
  final LoaderViewModelAuthStatusProvider authStatusProvider;

  LoaderViewModel({required this.context, required  this.authStatusProvider}) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final isAuth = await authStatusProvider.isAuth();
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