import 'package:cinemapedia/domain/entities/movie_entity.dart';

abstract class LocalStorageDatasource {
  Future<void> toggleFavorite(MovieEntity movie);

  Future<bool> isMovieFavorite(int movieId);

  Future<List<MovieEntity>> loadMovies({int limit = 10, offset = 0});
}
