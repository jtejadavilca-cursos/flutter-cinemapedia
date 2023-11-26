import 'package:cinemapedia/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> getNowPlaying({
    int page = 1,
  });
}
