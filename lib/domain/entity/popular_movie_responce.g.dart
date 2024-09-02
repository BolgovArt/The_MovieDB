// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_movie_responce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularMovieResponce _$PopularMovieResponceFromJson(
        Map<String, dynamic> json) =>
    PopularMovieResponce(
      page: (json['page'] as num).toInt(),
      movies: (json['results'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: (json['total_results'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
    );

Map<String, dynamic> _$PopularMovieResponceToJson(
        PopularMovieResponce instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.movies.map((e) => e.toJson()).toList(),
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
    };
