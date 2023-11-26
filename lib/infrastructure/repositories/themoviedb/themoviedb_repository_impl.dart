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
}
