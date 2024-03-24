import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/datasources/themoviedb/themoviedb_datasource_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/themoviedb/themoviedb_repository_impl.dart';

final movieRepositoryProvider =
    Provider((ref) => TheMovieDBRepositoryImpl(TheMovieDBDatasourceImpl()));
