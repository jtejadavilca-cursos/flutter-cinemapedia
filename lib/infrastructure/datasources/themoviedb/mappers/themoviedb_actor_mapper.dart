import 'package:cinemapedia/domain/entities/actor_entity.dart';
import 'package:cinemapedia/infrastructure/datasources/themoviedb/models/themoviedb_actors_response.dart';

abstract class TheMovieDBActorMapper {
  static ActorEntity toEntity(Cast cast) => ActorEntity(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w200${cast.profilePath}'
            : 'https://cdn.stealthoptional.com/images/ncavvykf/stealth/f60441357c6c210401a1285553f0dcecc4c4489e-564x564.jpg',
        character: cast.character,
      );
}
