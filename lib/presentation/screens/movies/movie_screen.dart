import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({
    super.key,
    required this.movieId,
  });

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovieDetail(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).getActorsByMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final MovieEntity? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) => _MovieDetails(movie: movie),
            ),
          )
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final MovieEntity movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getHeader(size, textStyle),
        _getSummary(),
        _ActorsByMovie(movieId: '${movie.id}'),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _getHeader(Size size, TextTheme textStyle) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              fit: BoxFit.cover,
              movie.posterPath,
              width: size.width * 0.3,
              height: 150,
              //width: 100,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: (size.width - 40) * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textStyle.titleLarge),
                Text(movie.overview),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getSummary() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        children: [
          ...movie.genreIds.map(
            (gender) => Container(
              margin: const EdgeInsets.only(right: 10),
              child: Chip(
                label: Text(gender),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  final MovieEntity movie;

  const _CustomSliverAppBar({
    required this.movie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * .7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            await ref
                .read(favoriteMoviesProvider.notifier)
                .toggleFavorite(movie);
            ref.invalidate(isFavoriteProvider(movie.id));
          },
          //icon: const Icon(Icons.favorite_border),
          //icon: const Icon(Icons.favorite_rounded, color: Colors.red),
          icon: isFavoriteFuture.when(
            loading: () => const CircularProgressIndicator(strokeWidth: 2),
            data: (isFavorite) => isFavorite
                ? const Icon(Icons.favorite_rounded, color: Colors.red)
                : const Icon(Icons.favorite_border),
            error: (_, __) => throw UnimplementedError(),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        centerTitle: false,
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.backdropPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  return loadingProgress != null
                      ? const SizedBox()
                      : FadeIn(child: child);
                },
              ),
            ),
            const _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.black54, Colors.transparent],
              stops: [0.0, 0.2],
            ),
            const _CustomGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black54],
              stops: [0.8, 1.0],
            ),
            const _CustomGradient(
              begin: Alignment.topLeft,
              colors: [Colors.black87, Colors.transparent],
              stops: [0.0, 0.3],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActorsByMovie extends ConsumerStatefulWidget {
  final String movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  _ActorsByMovieState createState() => _ActorsByMovieState();
}

class _ActorsByMovieState extends ConsumerState<_ActorsByMovie> {
  @override
  void initState() {
    super.initState();
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    final actors = actorsByMovie[widget.movieId];

    if (actors == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actorsByMovie.length,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                //* Nombre:
                const SizedBox(height: 5),
                Text(actor.name, maxLines: 2),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient({
    required this.colors,
    required this.stops,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}
