import 'package:json_annotation/json_annotation.dart';
import 'package:vk/domain/entity/movie_data_parser.dart';

part 'movie.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Movie {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  @JsonKey(fromJson: parseMovieDateFromString)
  final DateTime? releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final int? totalPages;
  final int? totalResults;

  Movie({
    required this.adult, 
    required this.backdropPath, 
    required this.genreIds, 
    required this.id, 
    required this.originalLanguage, 
    required this.originalTitle, 
    required this.overview, 
    required this.popularity, 
    required this.posterPath, 
    required this.releaseDate, 
    required this.title, 
    required this.video, 
    required this.voteAverage, 
    required this.voteCount, 
    required this.totalPages, 
    required this.totalResults
    });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  
  Map<String, dynamic> toJson() => _$MovieToJson(this);

}













