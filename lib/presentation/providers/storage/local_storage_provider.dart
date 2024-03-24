import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/datasources/local_storage/isar_local_storage_datasource_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage/isar_local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return IsarLocalStorageRepositoryImpl(IsarLocalStorageDatasourceImpl());
});
