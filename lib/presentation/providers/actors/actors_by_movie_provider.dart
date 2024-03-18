import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/actor_entity.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier,
    Map<String, List<ActorEntity>>>((ref) {
  final getActorsByMovie = ref.watch(actorsRepositoryProvider).getActorsByMovie;
  return ActorsByMovieNotifier(getActorsByMovie: getActorsByMovie);
});

typedef GetActorsCallback = Future<List<ActorEntity>> Function(
    String movieId);

class ActorsByMovieNotifier
    extends StateNotifier<Map<String, List<ActorEntity>>> {
  bool isLoading = false;
  String movieId = '0';
  final GetActorsCallback getActorsByMovie;

  ActorsByMovieNotifier({
    required this.getActorsByMovie,
  }) : super({});

  Future<void> loadActors(String movieId) async {
    if (isLoading) return;

    if (state[movieId] != null) return;

    isLoading = true;
    final List<ActorEntity> actorsByMovie = await getActorsByMovie(movieId);

    state = {...state, movieId: actorsByMovie};

    isLoading = false;
  }
}
