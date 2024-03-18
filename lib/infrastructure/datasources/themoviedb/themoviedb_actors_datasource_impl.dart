import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor_entity.dart';
import 'package:cinemapedia/infrastructure/datasources/themoviedb/mappers/themoviedb_actor_mapper.dart';
import 'package:cinemapedia/infrastructure/datasources/themoviedb/models/themoviedb_actors_response.dart';
import 'package:dio/dio.dart';

class TheMovieDBActorsDatasourceImpl extends ActorsDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbApiKey,
        'language': 'es-MX',
      },
    ),
  );

  List<ActorEntity> _jsonToActors(Map<String, dynamic> json) {
    final movieDBResponse = TheMovieDbCreditsResponse.fromJson(json);

    final List<ActorEntity> actors = movieDBResponse.cast
        .map((tmdb) => TheMovieDBActorMapper.toEntity(tmdb))
        .toList();

    return actors;
  }

  @override
  Future<List<ActorEntity>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    return _jsonToActors(response.data);
  }
}
