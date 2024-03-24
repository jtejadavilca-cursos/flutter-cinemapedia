import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, MovieEntity>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

/*
{
  id: MovieEntity,
  1234: MovieEntity,
  1235: MovieEntity,
  1236: MovieEntity,
}
*/
class StorageMoviesNotifier extends StateNotifier<Map<int, MovieEntity>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({
    required this.localStorageRepository,
  }) : super({});

  Future<List<MovieEntity>> loadNextPage() async {
    final movies =
        await localStorageRepository.loadMovies(offset: page * 10, limit: 20);

    if (movies.isNotEmpty) {
      page++;

      final temporalMap = {for (var v in movies) v.id: v};

      state = {...state, ...temporalMap};

      return movies;
    }
    return [];
  }

  Future<void> toggleFavorite(MovieEntity movie) async {
    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;
    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
