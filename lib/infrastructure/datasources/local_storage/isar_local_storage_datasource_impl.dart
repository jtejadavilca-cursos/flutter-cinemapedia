import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarLocalStorageDatasourceImpl extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarLocalStorageDatasourceImpl() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationCacheDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieEntitySchema],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;
    final MovieEntity? isFavoriteMovie =
        await isar.movieEntitys.filter().idEqualTo(movieId).findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<void> toggleFavorite(MovieEntity movie) async {
    final isar = await db;

    final favoriteMovie =
        await isar.movieEntitys.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie != null) {
      isar.writeTxnSync(
          () => isar.movieEntitys.deleteSync(favoriteMovie.isarId!));
      return;
    }

    isar.writeTxnSync(() => isar.movieEntitys.putSync(movie));
  }

  @override
  Future<List<MovieEntity>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;
    return await isar.movieEntitys
        .where()
        .offset(offset)
        .limit(limit)
        .findAll();
  }
}
