import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor_entity.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class TheMovieDBActorsRepositoryImpl extends ActorsRepository {
  final ActorsDatasource actorsDatasource;

  TheMovieDBActorsRepositoryImpl(this.actorsDatasource);

  @override
  Future<List<ActorEntity>> getActorsByMovie(String movieId) {
    return actorsDatasource.getActorsByMovie(movieId);
  }
}
