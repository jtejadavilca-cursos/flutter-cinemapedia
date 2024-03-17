import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, MovieEntity>>((ref) {
  final getMovie = ref.watch(movieRepositoryProvider).getMovieById;
  return MovieMapNotifier(getMovie: getMovie);
});

typedef GetMovieCallback = Future<MovieEntity> Function({String movieId});

class MovieMapNotifier extends StateNotifier<Map<String, MovieEntity>> {
  bool isLoading = false;
  String movieId = '0';
  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie,
  }) : super({});

  Future<void> loadMovieDetail(String movieId) async {
    if (isLoading) return;

    if (state[movieId] != null) return;

    print('Realizando la petición HTTP de movieId=$movieId');

    isLoading = true;
    final MovieEntity movie = await getMovie(movieId: movieId);

    state = {...state, movieId: movie};

    isLoading = false;
  }
}
