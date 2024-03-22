import 'package:cinemapedia/domain/entities/movie_entity.dart';

abstract class MoviesRepository {
  Future<List<MovieEntity>> getNowPlaying({int page = 1});

  Future<List<MovieEntity>> getPopular({int page = 1});

  Future<List<MovieEntity>> getUpcoming({int page = 1});

  Future<List<MovieEntity>> getTopRated({int page = 1});

  Future<MovieEntity> getMovieById({String movieId = '0'});

  Future<List<MovieEntity>> searchMovies(String query);
}
