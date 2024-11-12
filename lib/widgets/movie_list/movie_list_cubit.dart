import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:vk/domain/blocks/movie_list_bloc.dart';
import 'package:vk/domain/entity/movie.dart';

class MovieListRowData {
  final int id;
  final String posterPath;
  final String title;
  final String releaseDate;
  final String overview;

  MovieListRowData({
    required this.id,
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.overview,
  });
}

class MovieListCubitState {
  final List<MovieListRowData> movies;
  final String localeTag;

  const MovieListCubitState({
    required this.movies,
    required this.localeTag,
  });
  
  @override
  bool operator ==(Object other) =>
    identical(this, other) || 
    other is MovieListCubitState &&
      runtimeType == other.runtimeType &&
      movies == other.movies &&
      localeTag == other.localeTag;
  
  @override
  int get hashCode =>
    movies.hashCode ^ localeTag.hashCode;

  MovieListCubitState copyWith({
    List<MovieListRowData>? movies,
    String? localeTag,
  }) {
    return MovieListCubitState(
      movies: movies ?? this.movies, 
      localeTag: localeTag ?? this.localeTag, 
      );
  }
}

class MovieListCubit extends Cubit<MovieListCubitState> {
  final MovieListBloc movieListBloc;
  late final StreamSubscription<MovieListState> movieListBlocSubscription;
  late DateFormat _dateFormat;
  Timer? searchDebounce;

  MovieListCubit({
    // required MovieListCubitState initialState,
    required this.movieListBloc,
  // }) : super(initialState) {
  }) : super(const MovieListCubitState(
        movies: const <MovieListRowData>[], 
        localeTag: "",
      ),
    ) {
    Future.microtask(
      () {
        _onState(movieListBloc.state); // подписка на состояние
        movieListBlocSubscription = movieListBloc.stream.listen(_onState);
      },
    );
  }

  void _onState(MovieListState state) {
    final movies = state.movies.map(_makeRowData).toList(); // [1]: (в movie_list_bloc.dart)
    final newState = this.state.copyWith(movies: movies); // [2] (тут)
    emit(newState);
    // Каждый раз, когда будет приходить новый стейт с фильмами, он преобразуется из списка фильмов в тот список, 
    // который может показать экран, отображаем это все.
  }

  void setupLocale(String localeTag) {
    if (state.localeTag == localeTag) return;
    final newState = state.copyWith(localeTag: localeTag);
    emit(newState);
    _dateFormat = DateFormat.yMMMMd(localeTag);
    movieListBloc.add(MovieListEventLoadReset());
    movieListBloc.add(MovieListEventLoadNextPage(localeTag));
  }

  void showFilmAtIndex(int index) {
    if (index < state.movies.length - 1) return;
    movieListBloc.add(MovieListEventLoadNextPage(state.localeTag));
  }

  void searchFilms(String text) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(milliseconds: 300), () async {
      movieListBloc.add(MovieListEventLoadSearchMovie(text));
      movieListBloc.add(MovieListEventLoadNextPage(state.localeTag));
    });
  }
  
  

  @override
  Future<void> close() {
    movieListBlocSubscription.cancel();
    return super.close();
  }

  MovieListRowData _makeRowData(Movie movie) {
    final releaseDate = movie.releaseDate;
    final formatedReleaseDate = releaseDate != null ? _dateFormat.format(releaseDate) : '';
    return MovieListRowData(
      id: movie.id, 
      posterPath: movie.posterPath, 
      title: movie.title, 
      releaseDate: formatedReleaseDate, 
      overview: movie.overview
      );
  }
}

/* кубит - маленькое прокси, которое подготавливает данные для UI.
MovieListCubit создается с начальным стейтом и хранит локаль, на _onState слушает изменения стейта, которые происходят
в блоке фильмов и просто мапит фильмы оттуда (независимо. какие фильмы маппить - популярные или поисковые зависит от 
геттера в movie_lost_bloc.dart). Подготавливается новый стейт [2] и эмитит его.
setupLocale: когда падает новая локаль, подготавливается дейтформатор, резетается лист и запрашивается следующая 
страница с нужным локалТэгом.
showedMovieAtIndex: когда мы прокручиваем и доходим до конца, то запрашивается новая страница с этим же локалТэгом (тем
предыдущим, который уже сохранен в стейт).
searchMovie: когда происходит поиск, ждем его выполнения 3 секунды, потом устанавливается поиск и запрашивается новая 
страницаю
на close отменяются все подписки, дальше по коду функции мапы.
*/