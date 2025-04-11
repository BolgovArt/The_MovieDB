import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk/domain/api_client/account_api_client.dart';
import 'package:vk/domain/api_client/auth_api_client.dart';
import 'package:vk/domain/api_client/movie_api_client.dart';
import 'package:vk/domain/api_client/network_client.dart';
import 'package:vk/domain/data_providers/session_data_provider.dart';
import 'package:vk/domain/services/auth_service.dart';
import 'package:vk/domain/services/movie_service.dart';
import 'package:vk/library/FlutterSecureStorage/secure_storage.dart';
import 'package:vk/main.dart';
import 'package:vk/ui/navigation/main_navigation.dart';
import 'package:vk/ui/navigation/main_navigation_actions.dart';
import 'package:vk/widgets/app/my_app.dart';
import 'package:vk/widgets/authorization/authorization_model.dart';
import 'package:vk/widgets/authorization/authorization_widget.dart';
import 'package:vk/widgets/loader_widget/loader_view_model.dart';
import 'package:vk/widgets/loader_widget/loader_widget.dart';
import 'package:vk/widgets/main_screen/main_screen_model.dart';
import 'package:vk/widgets/main_screen/main_screen_widget.dart';
import 'package:vk/widgets/movie_details/film_page_model.dart';
import 'package:vk/widgets/movie_details/film_page_widget.dart';
import 'package:vk/widgets/movie_list/movie_list_model.dart';
import 'package:vk/widgets/movie_list/movies_list_widget.dart';
import 'package:vk/widgets/movie_trailer/movie_trailer_widget.dart';

AppFactory makeAppFactory() => _AppFactoryDefault();
    // ? а для чего нужен этот класс AppFactory
class _AppFactoryDefault implements AppFactory{
  final _diContainer = _DiContainer();

  _AppFactoryDefault();

  @override
  Widget makeApp() => MyApp(navigation: _diContainer._makeMyAppNavigation());
}

class _DiContainer {
  final _mainNavigationAction = const MainNavigationActions();
  final _secureStorage = const SecureStorageDefault(); // _secureStorage одно на все приложение
  // final AppHttpClient _httpClient = AppHttpClientDefault(); // тоже 1 на все приложение
  _DiContainer();
  // остальные создаются по требованию
  ScreenFactory _makeScreenFactory() => ScreenFactoryDefault(this);
  MyAppNavigation _makeMyAppNavigation() => MainNavigation(_makeScreenFactory());
  SessionDataProvider _makeSessionDataProvider() => SessionDataProviderDefault(secureStorage: _secureStorage); // можно создавать по необходимости
  NetworkClient _makeNetworkClient() => NetworkClientDefaults();
  AuthApiClient _makeAuthApiClient() => AuthApiClientDefault(networkClient: _makeNetworkClient());
  AccountApiClient _makeAccountApiClient() => AccountApiClientDefault(networkClient: _makeNetworkClient());
  AuthService _makeAuthService() => AuthService(
    authApiClient: _makeAuthApiClient(), 
    accountApiClient: _makeAccountApiClient(), 
    sessionDataProvider: _makeSessionDataProvider()
    );
  MovieApiClient _makeMovieApiClient() => MovieApiClientDefault(networkClient: _makeNetworkClient());
  MovieService _makeMovieService() => MovieService(
    movieApiClient: _makeMovieApiClient(), 
    sessionDataProvider: _makeSessionDataProvider(), 
    accountApiClient: _makeAccountApiClient(),
    );
  AuthViewModel _makeAuthViewModel() => AuthViewModel(
    mainNavigationActions: _mainNavigationAction, 
    loginProvider: _makeAuthService()                    // ? строчки не понял
  );
  LoaderViewModel _makeLoaderViewModel(BuildContext context) => LoaderViewModel(
    authStatusProvider: _makeAuthService(),
    context: context,
  );
  MoviePageModel _makeMoviePageModel(int movieId) => MoviePageModel(
    movieId,
    logoutProvider: _makeAuthService(), 
    movieProvider: _makeMovieService(), 
    mainNavigationActions: _mainNavigationAction
    );
  MovieListModel _makeMovieListModel() => MovieListModel(_makeMovieService());

  MainScreenModel _makeMainScreenModel() => MainScreenModel(_mainNavigationAction, authLogOut: ()=> _makeAuthService().logout(),);
}

class ScreenFactoryDefault implements ScreenFactory{
  final _DiContainer _diContainer;
  ScreenFactoryDefault(this._diContainer);
  @override
  Widget makeLoader() {
  return Provider(
    create: (context) => _diContainer._makeLoaderViewModel(context),
    lazy: false,
    child: const LoaderWidget(),
  );
  }

  @override
  Widget makeAuthWidget() {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeAuthViewModel(), 
      child:  const AuthorizationWidget()
    );
  }
  
  @override
  Widget makeMainScreenWidget() {
    return ChangeNotifierProvider(create: 
      (_) => _diContainer._makeMainScreenModel(),
      child: MainScreenWidget(screenFactory: this)
    );
  }

  @override
  Widget moviePageWidget(int movieId) {
    return ChangeNotifierProvider(
            create: (_) => _diContainer._makeMoviePageModel(movieId), 
            child: const MoviePageWidget(),
          );
  }

  @override
  Widget makeMovieTrailerWidget(youtubeKey) {
    return MovieTrailerWidget(youtubeKey: youtubeKey);
  }

  @override
  Widget makeNewsList() {
    return const NewsWidget();
  }

  @override
  Widget makeMovieList() {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeMovieListModel(), 
      child:  const MovieListWidget()
    );
  }

  @override
  Widget makeTVShowListWidget() {
    return const TVShowListWidget();
  }
}


/* Все приложение теперь собирается через фабрики, все закрыто протоколами (абстрактными классами), все 
через di. 

di_container.dart состоит из 3 классов - AppFactoryDefault, _DIContainer, ScreenFactoryDefault. Можно больше
Фабриками (AppFactoryDefault, ScreenFactoryDefault) пользуются снаружи. 
Сначала создали AppFactoryDefault для запуска приложения. Затем экраны создаются в main_navigation.dart - поэтому это тоже фабрика.
Когда каким-то внешним классам нужно создавать свои зависимости - используются фабрики, а там где
не нужно это все лежит в DIContainer и закрыто приватным.

В UI части в виджеты все внедряется через Provider. Это нужно не только для внедрения самих зависимостей,
но и для обновления экрана при изменении моделей. Вся сервисная часть собирается здесь либо в фабриках,
либо в DI контейнере. 

LoaderViewModel сама по себе является клеем между доменной частью и Ui частью, поэтому сама она создается
в DI контейнере, но используется уже фабрике (внедряется провайдером в UI)

*/