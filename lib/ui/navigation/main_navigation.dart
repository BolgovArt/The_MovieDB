import 'package:flutter/material.dart';
import 'package:vk/widgets/authorization/authorization_model.dart';
import 'package:vk/widgets/authorization/authorization_widget.dart';
import 'package:vk/widgets/main_screen/main_screen_widget.dart';
import 'package:vk/widgets/main_screen/messages/dialog.dart';

abstract class MainNavigationRouteNames {
  static const authorization = 'authorization';
  static const mainScreen = '/';
  static const movieDetails = '/dialog'; //!

}


class MainNavigation {
  String initialRoute(bool isAuthProgress) => isAuthProgress ? MainNavigationRouteNames.mainScreen : MainNavigationRouteNames.authorization;
  final routes = <String, WidgetBuilder>{
    MainNavigationRouteNames.authorization: (context) => AuthModelProvider(model: AuthModel(), child: const AuthorizationWidget()),
        MainNavigationRouteNames.mainScreen: (context) => const MainScreenWidget(),
        // '/main_screen/dialog': (context) {
        //   final arguments = ModalRoute.of(context)!.settings.arguments;
        //   if (arguments is int) {
        //   return DialogScreen(dialogId: arguments);
        //   } else {
        //     return DialogScreen(dialogId: 0);
        //   }
        // },
  };
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => DialogScreen (dialogId: movieId),
          );
        default: 
          const widget = Text('Navigation error');
          return MaterialPageRoute(builder: (context) => widget);
    }
  }
}