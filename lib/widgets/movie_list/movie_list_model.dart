import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vk/domain/api_client/api_client.dart';
import 'package:vk/domain/entity/movie.dart';
import 'package:vk/ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier{
  final _apiClient = ApiClient();
  final _movies = <Movie>[];
  List<Movie> get movies => List.unmodifiable(_movies);
  final _dateFormat = DateFormat.yMMMMd();
  late String locale;

  String stringFromDate(DateTime? date) => date != null ? _dateFormat.format(date) : ''; // DateFormat создается единожды, если оставить его в _widget.dart то он будет создаваться заново на каждый фильм

  void setupLocale(BuildContext context) {
    final locale = Localizations.localeOf(context);
  }

  Future<void> loadMovies() async {
    final moviesResponse = await _apiClient.popularFilms(1, 'ru-RU');
    _movies.addAll(moviesResponse.movies);
    notifyListeners();
  }

  void onFilmTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: id
    );
  }
}