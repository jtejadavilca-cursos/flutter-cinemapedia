import 'package:cinemapedia/infrastructure/datasources/themoviedb/themoviedb_actors_datasource_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/themoviedb/themoviedb_actors_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider =
    Provider((ref) => TheMovieDBActorsRepositoryImpl(TheMovieDBActorsDatasourceImpl()));
