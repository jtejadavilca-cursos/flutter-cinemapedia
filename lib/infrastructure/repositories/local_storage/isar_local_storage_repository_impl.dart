import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';

class IsarLocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource dataSource;

  IsarLocalStorageRepositoryImpl(this.dataSource);

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return dataSource.isMovieFavorite(movieId);
  }

  @override
  Future<List<MovieEntity>> loadMovies({int limit = 10, offset = 0}) {
    return dataSource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(MovieEntity movie) {
    return dataSource.toggleFavorite(movie);
  }
}
