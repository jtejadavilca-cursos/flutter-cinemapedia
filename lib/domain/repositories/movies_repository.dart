import 'package:cinemapedia/domain/entities/movie_entity.dart';

abstract class MoviesRepository {
  Future<List<MovieEntity>> getNowPlaying({int page});

  Future<List<MovieEntity>> getPopular({int page});

  Future<List<MovieEntity>> getUpcoming({int page});

  Future<List<MovieEntity>> getTopRated({int page});

  Future<MovieEntity> getMovieById({String movieId = '0'});
}
