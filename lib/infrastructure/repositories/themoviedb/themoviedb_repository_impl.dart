import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class TheMovieDBRepositoryImpl extends MoviesRepository {
  final MoviesDatasource moviesDatasource;
  TheMovieDBRepositoryImpl(this.moviesDatasource);

  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) {
    return moviesDatasource.getNowPlaying(page: page);
  }

  @override
  Future<List<MovieEntity>> getPopular({int page = 1}) {
    return moviesDatasource.getPopular(page: page);
  }

  @override
  Future<List<MovieEntity>> getTopRated({int page = 1}) {
    return moviesDatasource.getTopRated(page: page);
  }

  @override
  Future<List<MovieEntity>> getUpcoming({int page = 1}) {
    return moviesDatasource.getUpcoming(page: page);
  }
  
  @override
  Future<MovieEntity> getMovieById({String movieId = '0'}) {
    return moviesDatasource.getMovieById(movieId: movieId);
  }
}
