import 'package:flutter/material.dart';
import 'package:vk/domain/factories/screen_factory.dart';
import 'package:vk/library/widgets/inherited/provider.dart';
import 'package:vk/widgets/authorization/authorization_model.dart';
import 'package:vk/widgets/authorization/authorization_widget.dart';
import 'package:vk/widgets/loader_widget/loader_widget.dart';
import 'package:vk/widgets/main_screen/main_screen_model.dart';
import 'package:vk/widgets/main_screen/main_screen_widget.dart';
import 'package:vk/widgets/movie_details/film_page_model.dart';
import 'package:vk/widgets/movie_details/film_page_widget.dart';
import 'package:vk/widgets/movie_trailer/movie_trailer_widget.dart';

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
    MainNavigationRouteNames.authorization: (_) => NotifierProvider(
      create: () => AuthModel(), 
      child: const AuthorizationWidget()
    ),
    MainNavigationRouteNames.mainScreen: (context) => NotifierProvider(
      create: () => MainScreenModel(), 
      child: const MainScreenWidget()
    ),

  };
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
            // модель находится внутри builder, будет пересоздаваться постоянно. Расширяем файл provider.dart за счет stf виджета
            create: () =>  MoviePageModel(movieId), 
            child: const MoviePageWidget(),
          ),
        );
      case MainNavigationRouteNames.movieTrailerWidget:
        final arguments = settings.arguments;
        final youtubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (context) => MovieTrailerWidget(youtubeKey: youtubeKey),
        );
      default: 
        const widget = Text('Navigation error');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}