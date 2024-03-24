import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/storage/favorites_movies_provider.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;

    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();

    if (movies.isEmpty) {
      isLastPage = true;
    }

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    /*final favoritesLoading = ref.watch(favoritesLoadingProvider);
    if (favoritesLoading) return const FullScreenLoader();*/

    final favoritesMovies = ref.watch(favoriteMoviesProvider).values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites View')),
      body: MoviesMasonry(
        loadNextPage: loadNextPage,
        movies: favoritesMovies,
      ),
    );
  }
}
