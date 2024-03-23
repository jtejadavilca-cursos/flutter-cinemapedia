import 'dart:async';

import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';

typedef SearchMoviesCallback = Future<List<MovieEntity>> Function(String query);

class SearchMoviesDelegate extends SearchDelegate<MovieEntity?> {
  final SearchMoviesCallback searchMovies;
  final StreamController<List<MovieEntity>> debouncedMovies =
      StreamController.broadcast();

  Timer? _debounceTimer;

  SearchMoviesDelegate({required this.searchMovies});

  void _onQueryChange(String query) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        debouncedMovies.add([]);
        return;
      }

      final movies = await searchMovies(query);
      debouncedMovies.add(movies);
    });
  }

  void _clearStreams() {
    debouncedMovies.close();
  }

  @override
  void close(BuildContext context, MovieEntity? result) {
    _clearStreams();
    super.close(context, result);
  }

  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_ios_new_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('BuildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChange(query);
    return StreamBuilder(
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) =>
              _MovieItem(movie: movies[index], onMovieSelected: close),
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  const _MovieItem({
    required this.movie,
    required this.onMovieSelected,
  });

  final MovieEntity movie;
  final Function onMovieSelected;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * .2,
              height: 110,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(fit: BoxFit.cover, movie.posterPath,
                    loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const CircularProgressIndicator();
                  }

                  return FadeIn(child: child);
                }),
              ),
            ),
            const SizedBox(width: 15),
            SizedBox(
              width: size.width * .7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyle.titleMedium),
                  (movie.overview.length <= 100)
                      ? Text(movie.overview)
                      : Text('${movie.overview.substring(0, 100)}...'),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(HumanFormats.number(movie.voteAverage, 1),
                          style: textStyle.bodyMedium!
                              .copyWith(color: Colors.yellow.shade900)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
