import 'package:provider/provider.dart';
import 'package:vk/library/widgets/inherited/provider.dart' as old_provider;
import 'package:vk/widgets/authorization/authorization_model.dart';
import 'package:vk/widgets/authorization/authorization_widget.dart';
import 'package:vk/widgets/loader_widget/loader_view_model.dart';
import 'package:vk/widgets/loader_widget/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:vk/widgets/main_screen/main_screen_widget.dart';
import 'package:vk/widgets/movie_details/film_page_model.dart';
import 'package:vk/widgets/movie_details/film_page_widget.dart';
import 'package:vk/widgets/movie_list/movie_list_model.dart';
import 'package:vk/widgets/movie_list/movies_list_widget.dart';
import 'package:vk/widgets/movie_trailer/movie_trailer_widget.dart';

class ScreenFactory {

  Widget makeLoader() {
  return Provider(
    create: (context) => LoaderViewModel(context),
    lazy: false,
    child: const LoaderWidget(),
  );
  }

  Widget makeAuthWidget() {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(), 
      child:  const AuthorizationWidget()
    );
  }
  
  Widget makeMainScreenWidget() {
    return MainScreenWidget();
  }

  Widget moviePageWidget(int movieId) {
    return ChangeNotifierProvider(
            create: (_) =>  MoviePageModel(movieId), 
            child: const MoviePageWidget(),
          );
  }

  Widget makeMovieTrailerWidget(youtubeKey) {
    return MovieTrailerWidget(youtubeKey: youtubeKey);
  }

  Widget makeNewsList() {
    return const NewsWidget();
  }

  Widget makeMovieList() {
    return ChangeNotifierProvider(
      create: (_) => MovieListModel(), 
      child:  const MovieListWidget()
    );
  }

  Widget makeTVShowListWidget() {
    return const TVShowListWidget();
  }
}