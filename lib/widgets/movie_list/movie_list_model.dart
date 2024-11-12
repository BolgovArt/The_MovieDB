// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:vk/domain/entity/movie.dart';
// import 'package:vk/domain/services/movie_service.dart';
// import 'package:vk/library/widgets/inherited/localized_model.dart';
// import 'package:vk/library/widgets/paginator.dart.dart';
// import 'package:vk/ui/navigation/main_navigation.dart';

// class MovieListRowData {
//   final int id;
//   final String posterPath;
//   final String title;
//   final String releaseDate;
//   final String overview;
//   MovieListRowData({
//     required this.id,
//     required this.posterPath,
//     required this.title,
//     required this.releaseDate,
//     required this.overview,
//   });
// }

// class MovieListModel extends ChangeNotifier{
//   final _movieService = MovieService();
//   late final Paginator<Movie> _popularMoviePaginator;
//   late final Paginator<Movie> _searchMoviePaginator;

//   // String _locale = '';
//   final _localeStorage = LocalizedModelStorage();
//   Timer? searchDebounce; 

//   var _movies = <MovieListRowData>[];
//   String? _searchQuery;
//     bool get isSearchMode {
//     final searchQuery = _searchQuery;
//     return searchQuery != null && searchQuery.isNotEmpty;
//   }

//   List<MovieListRowData> get movies => List.unmodifiable(_movies);
//   late DateFormat _dateFormat;

//   MovieListModel() {
//     _popularMoviePaginator = Paginator<Movie>((page) async {
//       final result = await _movieService.popularFilms(page, _localeStorage.localeTag);
//       return PaginatorLoadResult(data: result.movies, currentPage: result.page, totalPage: result.totalPages);
//     });
//     _searchMoviePaginator = Paginator<Movie>((page) async {
//       final result = await _movieService.searchFilms(page, _localeStorage.localeTag, _searchQuery ?? '');
//       return PaginatorLoadResult(data: result.movies, currentPage: result.page, totalPage: result.totalPages);
//     });
//   }


//   MovieListRowData _makeRowData(Movie movie) {
//     final releaseDate = movie.releaseDate;
//     final formatedReleaseDate = releaseDate != null ? _dateFormat.format(releaseDate) : '';
//     return MovieListRowData(
//       id: movie.id, 
//       posterPath: movie.posterPath, 
//       title: movie.title, 
//       releaseDate: formatedReleaseDate, 
//       overview: movie.overview
//       );
//   }


//   void setupLocale(Locale locale) async {
//     // final locale = Localizations.localeOf(context).toLanguageTag();
//     // print(locale); // Должена быть Ru. В видосе только на Ihone установил ru, Android потом сказал
//     if (!_localeStorage.updateLocale(locale)) return;

//     _dateFormat = DateFormat.yMMMMd(_localeStorage.localeTag);
//     await _resetList();

//   }

//   Future<void> _resetList() async {
//     await _popularMoviePaginator.reset();
//     await _searchMoviePaginator.reset();
//     _movies.clear();
//     await _loadNextPage();
//   }


// // функция для определения, находимся ли мы сейчас в состоянии поиска или нет
//   Future<void> _loadNextPage() async {
//     // final searchQuery = _searchQuery;
//     if(isSearchMode) {
//       await _searchMoviePaginator.loadNextPage();
//       _movies = _searchMoviePaginator.data.map(_makeRowData).toList();
//     } else {
//       await _popularMoviePaginator.loadNextPage();
//       _movies = _popularMoviePaginator.data.map(_makeRowData).toList();
//     }
//     notifyListeners();
//   }

//   void onFilmTap(BuildContext context, int index) {
//     final id = _movies[index].id;
//     Navigator.of(context).pushNamed(
//       MainNavigationRouteNames.movieDetails,
//       arguments: id
//     );
//   }

//   void showFilmAtIndex(index) {
//     if (index < _movies.length - 1) return;
//     _loadNextPage();
//   }


//   Future<void> searchFilms(String text) async {
//     searchDebounce?.cancel();
//     searchDebounce = Timer(const Duration(microseconds: 250), () async {
//       final searchQuery = text.isNotEmpty ? text : null;
//       if (_searchQuery == searchQuery) return;
//       _searchQuery = searchQuery;
//       _movies.clear();
//       if (isSearchMode) {
//         await _searchMoviePaginator.reset();
//       }
//       _loadNextPage();
//     });
//   }
// }