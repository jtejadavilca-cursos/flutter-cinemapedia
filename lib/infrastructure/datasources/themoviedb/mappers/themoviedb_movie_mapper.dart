import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/infrastructure/datasources/themoviedb/models/themoviedb_movie.dart';

class TheMovieDBMovieMapper {
  static MovieEntity movieDBToEntity(TheMovieDBMovie tmdbMovie) => MovieEntity(
        adult: tmdbMovie.adult,
        backdropPath: tmdbMovie.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500${tmdbMovie.backdropPath}'
            : '',
        genreIds: tmdbMovie.genreIds.map((e) => e.toString()).toList(),
        id: tmdbMovie.id,
        originalLanguage: tmdbMovie.originalLanguage,
        originalTitle: tmdbMovie.originalTitle,
        overview: tmdbMovie.overview,
        popularity: tmdbMovie.popularity,
        posterPath: tmdbMovie.posterPath != ''
            ? 'https://image.tmdb.org/t/p/w500${tmdbMovie.posterPath}'
            : '',
        releaseDate: tmdbMovie.releaseDate,
        title: tmdbMovie.title,
        video: tmdbMovie.video,
        voteAverage: tmdbMovie.voteAverage,
        voteCount: tmdbMovie.voteCount,
      );
}
