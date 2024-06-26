import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final moviesSlideshowProvider = Provider<List<MovieEntity>>((ref) {
  final nowPlayinMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayinMovies.isEmpty) return [];

  int length = nowPlayinMovies.length;

  return nowPlayinMovies.sublist(0, length >= 6 ? 6 : length);
});
