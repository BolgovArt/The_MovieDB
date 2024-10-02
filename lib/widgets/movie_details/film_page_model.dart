import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vk/domain/api_client/api_client_exception.dart';
import 'package:vk/domain/entity/movie_details.dart';
import 'package:vk/domain/services/auth_service.dart';
import 'package:vk/domain/services/movie_service.dart';
import 'package:vk/library/widgets/inherited/localized_model.dart';
import 'package:vk/ui/navigation/main_navigation.dart';

// агрегация - объединение 3 свойств в одно
class MoviePagePosterData {
  final String? backdropPath;
  final String? posterPath;
  final bool isFavorite;
  IconData get favoriteIcon => isFavorite ? Icons.favorite : Icons.favorite_outline; 

  MoviePagePosterData({
      this.backdropPath, 
      this.posterPath, 
      bool isFavorite = false,
    }): isFavorite = isFavorite;

  MoviePagePosterData copyWith({
    String? backdropPath,
    String? posterPath,
    bool? isFavorite,
  }) {
    return MoviePagePosterData(
      backdropPath: backdropPath ?? this.backdropPath,
      posterPath: posterPath ?? this.posterPath,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class MoviePageMovieNameData {
  final String name;
  final String year;

  MoviePageMovieNameData({
    required this.name, 
    required this.year
  });
}

class MoviePageMovieScoreData {
  final double voteAverage;
  final String? trailerKey;

  MoviePageMovieScoreData({
    required this.voteAverage, 
    this.trailerKey
  });
}

class MoviePageMoviePeopleData {
  String name;
  String job;
  MoviePageMoviePeopleData({
    required this.name,
    required this.job,
  });
}

class MoviePageMovieActorData {
  final String name;
  final String character;
  final String? profilePath;
  MoviePageMovieActorData({
    required this.name,
    required this.character,
    this.profilePath,
  });
}

class MoviePageData {
  String title = "";
  bool isLoading = true;
  String overview = "";
  MoviePagePosterData posterData = MoviePagePosterData();
  MoviePageMovieNameData nameData = MoviePageMovieNameData(name: '', year: '');
  MoviePageMovieScoreData scoreData = MoviePageMovieScoreData(voteAverage: 0,);
  String summary = '';
  List<List<MoviePageMoviePeopleData>> peopleData = const <List<MoviePageMoviePeopleData>>[];
  List<MoviePageMovieActorData> actorData = const <MoviePageMovieActorData>[];

}

class MoviePageModel extends ChangeNotifier { 
  final _authService = AuthService();
  final _movieService = MovieService();


  final int movieId; 
  final data = MoviePageData();
  final _localeStorage = LocalizedModelStorage();
  late DateFormat _dateFormat;

  MoviePageModel(this.movieId);


  Future<void> setupLocale(BuildContext context, Locale locale) async {
    if (!_localeStorage.updateLocale(locale)) return;

    _dateFormat = DateFormat.yMMMMd(_localeStorage.localeTag);
    updateData(null, false);
    await loadDetails(context);
  }

  Future<void> loadDetails(BuildContext context) async {
    try {
      final details = await _movieService.loadDetails(movieId: movieId, locale: _localeStorage.localeTag);
      updateData(details.details, details.isFavorite);
    } on ApiClientException catch (e) {
    _handleApiClientException(e, context);
    }
  }


  void updateData(MovieDetails? details, bool isFavorite) {
    data.title = details?.title ?? "Загрузка.."; // проверка на null ?? 'Загрузка..'
    data.isLoading = details == null;            // details == null - это bool выражение, true/false
    
    if (details == null) {
      notifyListeners();
      return;
    }

    data.overview = details.overview ?? '';
    data.posterData = MoviePagePosterData(
        backdropPath: details.backdropPath, 
        posterPath: details.posterPath, 
        isFavorite: isFavorite,
      );
    var year = details.releaseDate?.year.toString();
    year = year != null ? ' ($year)' : '';
    data.nameData = MoviePageMovieNameData(
      name: details.title, 
      year: year,
    );

    final videos = details.videos.results.where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos.isNotEmpty == true ? videos.first.key : null;
    data.scoreData = MoviePageMovieScoreData(
      voteAverage: details.voteAverage * 10 ,
      trailerKey: trailerKey,
    );
    data.summary = makeSummary(details);
    data.peopleData = makePeopleData(details);
    data.actorData = details.credits.cast.map((e) => MoviePageMovieActorData(
        name: e.name, 
        character: e.character, 
        profilePath: e.profilePath,
      )
    ).toList();

    notifyListeners();
  }

// инкапсуляция
  String makeSummary(MovieDetails details) {
    final releaseDate = details.releaseDate;

    var texts = <String>[];
    if (releaseDate != null) {
      texts.add(_dateFormat.format(releaseDate));
    }
    if (details.productionCountries.isNotEmpty) {
      texts.add('(${details.productionCountries.first.iso})');
    }

    final runtime = details.runtime ?? 0;
    final duration = Duration(minutes: runtime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    texts.add('${hours}h ${minutes}m');
    
    if (details.genres.isNotEmpty) {
      var genresNames = <String>[];
      for (var element in details.genres) {
        genresNames.add(element.name);
      }
      texts.add(genresNames.join(', '));
    }

    return texts.join(' ');
  }

  List<List<MoviePageMoviePeopleData>> makePeopleData(MovieDetails details) {
    var crew = details.credits.crew.map((e) => MoviePageMoviePeopleData(name: e.name, job: e.job)).toList();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;
    var crewChunks = <List<MoviePageMoviePeopleData>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks.add(
        crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2),
      );
    }
    return crewChunks;
  }

  Future<void> toggleFavorite(BuildContext context) async { 
    data.posterData = data.posterData.copyWith(isFavorite: !data.posterData.isFavorite);
    

    notifyListeners();
    try {
      await _movieService.updateFavorite(movieId: movieId, isFavorite: data.posterData.isFavorite);
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  void _handleApiClientException(ApiClientException exeption, BuildContext context){
    switch (exeption.type) {
        case ApiClientExceptionType.sessionExpired:
          _authService.logout();
          MainNavigation.resetNavigation(context);
          break;
        default:
          print(exeption);
      }
  }

}
