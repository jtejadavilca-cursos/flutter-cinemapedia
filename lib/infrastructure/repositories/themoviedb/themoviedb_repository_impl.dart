import 'package:cinemapedia/domain/datasources/movie_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/domain/repositories/movie_repository.dart';

class TheMovieDBRepositoryImpl extends MovieRepository {
  final MovieDatasource movieDatasource;
  TheMovieDBRepositoryImpl(this.movieDatasource);

  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) {
    return movieDatasource.getNowPlaying(page: page);
  }

  @override
  Future<List<MovieEntity>> getPopular({int page = 1}) {
    return movieDatasource.getPopular(page: page);
  }

  @override
  Future<List<MovieEntity>> getTopRated({int page = 1}) {
    return movieDatasource.getTopRated(page: page);
  }

  @override
  Future<List<MovieEntity>> getUpcoming({int page = 1}) {
    return movieDatasource.getUpcoming(page: page);
  }
  
  @override
  Future<MovieEntity> getMovieById({String movieId = '0'}) {
    return movieDatasource.getMovieById(movieId: movieId);
  }
}
