import 'package:dio/dio.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';

import 'package:cinemapedia/infrastructure/datasources/themoviedb/models/models.dart';
import 'package:cinemapedia/infrastructure/datasources/themoviedb/mappers/themoviedb_movie_mapper.dart';

class TheMovieDBDatasourceImpl extends MoviesDatasource {
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
        .where((thdb) =>
            thdb.posterPath != null && thdb.posterPath.toString().isNotEmpty)
        .map((tmdb) => TheMovieDBMovieMapper.movieDBToEntity(tmdb))
        .toList();

    return movies;
  }

  MovieEntity _jsonToMovie(Map<String, dynamic> json) {
    final tmdbDet = TheMovieDbDetails.fromJson(json);

    final MovieEntity movie = TheMovieDBMovieMapper.movieDBDetToEntity(tmdbDet);

    return movie;
  }

  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<MovieEntity>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<MovieEntity>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<MovieEntity>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<MovieEntity> getMovieById({String movieId = '0'}) async {
    final response = await dio.get('/movie/$movieId');

    return _jsonToMovie(response.data);
  }

  @override
  Future<List<MovieEntity>> searchMovies(String query) async {
    final response = await dio.get(
      '/search/movie',
      queryParameters: {'query': query},
    );

    return _jsonToMovies(response.data);
  }
}
