import 'package:flutter/material.dart';
import 'package:vk/ui/navigation/main_navigation_route_names.dart';
import 'package:vk/widgets/app/my_app.dart';

abstract class ScreenFactory {
  Widget makeLoader();
  Widget makeAuthWidget();
  Widget makeMainScreenWidget();
  Widget moviePageWidget(int movieId);
  Widget makeMovieTrailerWidget(youtubeKey);
  Widget makeNewsList();
  Widget makeMovieList();
  Widget makeTVShowListWidget();
}

class MainNavigation implements MyAppNavigation {
  final ScreenFactory screenFactory;
  const MainNavigation(this.screenFactory);
  @override
  Map<String, Widget Function(BuildContext)> get routes => {
    MainNavigationRouteNames.loaderWidget: (_) => screenFactory.makeLoader(),
    MainNavigationRouteNames.authorization: (_) => screenFactory.makeAuthWidget(),
    MainNavigationRouteNames.mainScreen: (_) => screenFactory.makeMainScreenWidget(),

  };
  @override
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => screenFactory.moviePageWidget(movieId),
        );
      case MainNavigationRouteNames.movieTrailerWidget:
        final arguments = settings.arguments;
        final youtubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (_) => screenFactory.makeMovieTrailerWidget(youtubeKey),
        );
      default: 
        const widget = Text('Navigation error');
        return MaterialPageRoute(builder: (_) => widget);
    }
  }
}