import 'package:flutter/material.dart';
import 'package:vk/ui/navigation/main_navigation_actions.dart';

class MainScreenModel extends ChangeNotifier{
  final Future<void> Function() authLogOut;
  final MainNavigationActions mainNavigationAction;
  MainScreenModel(this.mainNavigationAction, {required this.authLogOut});
  Future<void> logout(BuildContext context) async {
    await authLogOut();
    mainNavigationAction.resetNavigation(context);
  }

}