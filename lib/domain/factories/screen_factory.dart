import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vk/domain/blocks/auth_bloc.dart';
import 'package:vk/domain/blocks/movie_list_bloc.dart';
import 'package:vk/widgets/authorization/authorization_view_cubit.dart';
import 'package:vk/widgets/authorization/authorization_widget.dart';
import 'package:vk/widgets/loader_widget/loader_view_cubit.dart';
import 'package:vk/widgets/loader_widget/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:vk/widgets/main_screen/main_screen_widget.dart';
import 'package:vk/widgets/movie_details/film_page_model.dart';
import 'package:vk/widgets/movie_details/film_page_widget.dart';
import 'package:vk/widgets/movie_list/movie_list_cubit.dart';
import 'package:vk/widgets/movie_list/movie_list_model.dart';
import 'package:vk/widgets/movie_list/movies_list_widget.dart';
import 'package:vk/widgets/movie_trailer/movie_trailer_widget.dart';

class ScreenFactory {

  AuthBloc? _authBloc; //*

  Widget makeLoader() {
    final authBloc = _authBloc ?? AuthBloc(AuthCheckStatusInProgressState()); // в самом начале когда makeLoader создаем, проверяем, есть ли у нас authbloc или нет. Если нет - создаем
      _authBloc = authBloc; //* ~если authBloc пересоздается, его надо положить туда, чтобы он хранился~
    return BlocProvider<LoaderViewCubit>(
      create: (context) => LoaderViewCubit(LoaderViewCubitState.unknown, authBloc),
      // lazy: false,
      child: const LoaderWidget(),
    );
  }
  

  Widget makeAuthWidget() {
    final authBloc = _authBloc ?? AuthBloc(AuthCheckStatusInProgressState()); // в самом начале когда makeLoader создаем, проверяем, есть ли у нас authbloc или нет. Если нет - создаем
      _authBloc = authBloc;
      return BlocProvider<AuthViewCubit>(
        create: (_) => AuthViewCubit(
          AuthViewCubitFormFillInProgressState(), 
          authBloc,
        ),
        child: const AuthorizationWidget(),
      );
  }
  
  Widget makeMainScreenWidget() {
    _authBloc?.close();
    _authBloc = null;
    return const MainScreenWidget();
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
    return BlocProvider(
      create: (_) => MovieListCubit(
        movieListBloc: MovieListBloc(const MovieListState.inital())), 
      child:  const MovieListWidget()
    );
  }

  Widget makeTVShowListWidget() {
    return const TVShowListWidget();
  }
}