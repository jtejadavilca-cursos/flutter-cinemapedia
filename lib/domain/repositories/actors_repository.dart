import 'package:cinemapedia/domain/entities/actor_entity.dart';

abstract class ActorsRepository {
  Future<List<ActorEntity>> getActorsByMovie(String movieId);
}