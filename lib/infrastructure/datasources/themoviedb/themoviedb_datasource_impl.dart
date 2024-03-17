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
        'api_key': Environment.theMovieDbApiKey,
        'language': 'es-MX',
      },
    ),
  );

  List<MovieEntity> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = TheMovieDBResponse.fromJson(json);

    final List<MovieEntity> movies = movieDBResponse.results
        .where((thdb) => thdb.posterPath.startsWith('/'))
        .map((tmdb) => TheMovieDBMovieMapper.movieDBToEntity(tmdb))
        .toList();

    return movies;
  }

  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: Map.from({'page': page}),
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<MovieEntity>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: Map.from({'page': page}),
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<MovieEntity>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: Map.from({'page': page}),
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<MovieEntity>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: Map.from({'page': page}),
    );

    return _jsonToMovies(response.data);
  }
}
