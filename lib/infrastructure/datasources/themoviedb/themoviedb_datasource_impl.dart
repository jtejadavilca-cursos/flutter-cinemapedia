import 'package:cinemapedia/config/constants/environment.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia/domain/datasources/movie_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';

import 'package:cinemapedia/infrastructure/datasources/themoviedb/mappers/themoviedb_movie_mapper.dart';
import 'package:cinemapedia/infrastructure/datasources/themoviedb/models/themoviedb_response.dart';

class TheMovieDBDatasourceImpl extends MovieDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.THE_MOVIEDB_KEY,
        'language': 'es-MX',
      },
    ),
  );
  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: Map.from({'page': page}),
    );
    TheMovieDBResponse tmdbResp = TheMovieDBResponse.fromJson(response.data);

    final List<MovieEntity> movies = tmdbResp.results
        .where((thdb) => thdb.posterPath.startsWith('/'))
        .map(TheMovieDBMovieMapper.movieDBToEntity)
        .toList();

    return movies;
  }
}
