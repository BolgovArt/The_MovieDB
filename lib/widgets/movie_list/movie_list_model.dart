import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vk/domain/api_client/movie_api_client.dart';
import 'package:vk/domain/entity/movie.dart';
import 'package:vk/domain/entity/popular_movie_responce.dart';
import 'package:vk/ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier{
  final _movieApiClient = MovieApiClient();
  final _movies = <Movie>[];
  late int _currentPage;
  late int _totalPage;
  var _isLoadingInProgress = false;
  String? _searchQuery;
  List<Movie> get movies => List.unmodifiable(_movies);
  // final _dateFormat = DateFormat.yMMMMd();
  late DateFormat _dateFormat;
  String _locale = '';
  Timer? searchDebounce; 

  String stringFromDate(DateTime? date) => date != null ? _dateFormat.format(date) : ''; // DateFormat создается единожды, если оставить его в _widget.dart то он будет создаваться заново на каждый фильм

  void setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    print(locale); // Должена быть Ru. В видосе только на Ihone установил ru, Android потом сказал
    if (_locale == locale) return; 
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await _resetList();

  }

  Future<void> _resetList() async {
    _movies.clear();
    _currentPage = 0;
    _totalPage = 1;
    await _loadNextPage();
  }

  Future<PopularMovieResponce> _loadFilms(int nextPage, String locale) async {
    final query = _searchQuery;
    if (query == null) {
      return await _movieApiClient.popularFilms(nextPage, _locale);
    } else {
      return await _movieApiClient.searchFilms(nextPage, _locale, query);
    }
  }
  

  Future<void> _loadNextPage() async {
    if (_isLoadingInProgress || _currentPage >= _totalPage) return;
    _isLoadingInProgress = true;
    final nextPage = _currentPage + 1;
    try {
    final moviesResponse = await _loadFilms(nextPage, _locale);
    // _currentPage = moviesResponse.page;
    _currentPage++;
    _totalPage++;
    _movies.addAll(moviesResponse.movies);
    _isLoadingInProgress = false;
    notifyListeners();
    } catch (e) {
      _isLoadingInProgress = false;
      // какое-то оповещение пользователю
    }
  }

  void onFilmTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: id
    );
  }

  void showFilmAtIndex(index) {
    if (index < _movies.length - 1) return;
    _loadNextPage();
  }


  Future<void> searchFilms(String text) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(microseconds: 250), () async {
      final searchQuery = text.isNotEmpty ? text : null;
    if (_searchQuery == searchQuery) return;
    _searchQuery = searchQuery;
    await _resetList();
    });
  }

}