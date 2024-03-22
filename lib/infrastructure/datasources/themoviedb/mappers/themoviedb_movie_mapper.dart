import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/infrastructure/datasources/themoviedb/models/themoviedb_details.dart';
import 'package:cinemapedia/infrastructure/datasources/themoviedb/models/themoviedb_movie.dart';

abstract class TheMovieDBMovieMapper {
  static MovieEntity movieDBToEntity(TheMovieDBMovie tmdbMovie) => MovieEntity(
        adult: tmdbMovie.adult,
        backdropPath: tmdbMovie.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500${tmdbMovie.backdropPath}'
            : 'https://ih1.redbubble.net/image.1893341687.8294/fposter,small,wall_texture,product,750x1000.jpg',
        genreIds: tmdbMovie.genreIds.map((e) => e.toString()).toList(),
        id: tmdbMovie.id,
        originalLanguage: tmdbMovie.originalLanguage,
        originalTitle: tmdbMovie.originalTitle,
        overview: tmdbMovie.overview,
        popularity: tmdbMovie.popularity,
        posterPath: tmdbMovie.posterPath != null &&
                tmdbMovie.posterPath.toString().isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500${tmdbMovie.posterPath}'
            : 'https://www.prokerala.com/movies/assets/img/no-poster-available.jpg',
        releaseDate: tmdbMovie.releaseDate != null
            ? tmdbMovie.releaseDate!
            : DateTime.now(),
        title: tmdbMovie.title,
        video: tmdbMovie.video,
        voteAverage: tmdbMovie.voteAverage,
        voteCount: tmdbMovie.voteCount,
      );

  static MovieEntity movieDBDetToEntity(TheMovieDbDetails tmdbDetails) =>
      MovieEntity(
        adult: tmdbDetails.adult,
        backdropPath: tmdbDetails.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500${tmdbDetails.backdropPath}'
            : 'https://ih1.redbubble.net/image.1893341687.8294/fposter,small,wall_texture,product,750x1000.jpg',
        genreIds: tmdbDetails.genres.map((e) => e.name).toList(),
        id: tmdbDetails.id,
        originalLanguage: tmdbDetails.originalLanguage,
        originalTitle: tmdbDetails.originalTitle,
        overview: tmdbDetails.overview,
        popularity: tmdbDetails.popularity,
        posterPath: tmdbDetails.posterPath != ''
            ? 'https://image.tmdb.org/t/p/w500${tmdbDetails.posterPath}'
            : 'https://ih1.redbubble.net/image.1893341687.8294/fposter,small,wall_texture,product,750x1000.jpg',
        releaseDate: tmdbDetails.releaseDate,
        title: tmdbDetails.title,
        video: tmdbDetails.video,
        voteAverage: tmdbDetails.voteAverage,
        voteCount: tmdbDetails.voteCount,
      );
}
