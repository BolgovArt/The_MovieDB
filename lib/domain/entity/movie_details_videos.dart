import 'package:json_annotation/json_annotation.dart';

part 'movie_details_videos.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieDetailsVideos {
  final List<MovieDetailsVideosResult> results;
  MovieDetailsVideos({
    required this.results,
  });

  factory MovieDetailsVideos.fromJson(Map<String, dynamic> json) => _$MovieDetailsVideosFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailsVideosToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieDetailsVideosResult {
  @JsonKey(name: 'iso_639_1')
  final String iso1;
  @JsonKey(name: 'iso_3166_1')
  final String iso2;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String publishedAt;
  final String id;
  MovieDetailsVideosResult({
    required this.iso1,
    required this.iso2,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  factory MovieDetailsVideosResult.fromJson(Map<String, dynamic> json) => _$MovieDetailsVideosResultFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailsVideosResultToJson(this);
}