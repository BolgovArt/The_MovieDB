// В main_navigation теперь описаны только маршруты, кода по созданию экрана тут больше нет, они переехали в screen_factory.dart
import 'package:flutter/material.dart';
import 'package:vk/domain/factories/screen_factory.dart';

abstract class MainNavigationRouteNames {
  static const loaderWidget = '/';
  static const authorization = 'authorization';
  static const mainScreen = '/main_screen';
  static const movieDetails = '/movie_details'; 
  static const movieTrailerWidget = '/movie_details/trailer'; 
}


class MainNavigation {
  static final _screenFactory = ScreenFactory();
  final routes = <String, WidgetBuilder>{
    MainNavigationRouteNames.loaderWidget: (_) => _screenFactory.makeLoader(),
    MainNavigationRouteNames.authorization: (_) => _screenFactory.makeAuthWidget(),
    MainNavigationRouteNames.mainScreen: (_) => _screenFactory.makeMainScreenWidget(),

  };
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.moviePageWidget(movieId),
        );
      case MainNavigationRouteNames.movieTrailerWidget:
        final arguments = settings.arguments;
        final youtubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeMovieTrailerWidget(youtubeKey),
        );
      default: 
        const widget = Text('Navigation error');
        return MaterialPageRoute(builder: (_) => widget);
    }
  }

  static void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      MainNavigationRouteNames.loaderWidget, (route) => false
    );
  }
}