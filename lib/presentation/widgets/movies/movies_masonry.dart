import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_poster_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MoviesMasonry extends StatefulWidget {
  final List<MovieEntity> movies;
  final VoidCallback? loadNextPage;

  const MoviesMasonry({
    super.key,
    required this.movies,
    this.loadNextPage,
  });

  @override
  State<MoviesMasonry> createState() => _MoviesMasonryState();
}

class _MoviesMasonryState extends State<MoviesMasonry> {
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  bool isMounted = true;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage != null &&
          scrollController.position.pixels + 100 >=
              scrollController.position.maxScrollExtent) {
        isLoading = true;
        widget.loadNextPage!();
        isLoading = false;
      }
    });
  }

  @override
  void dispose() {
    isMounted = false;
    scrollController.dispose();
    super.dispose();
  }

  Future<void> onRefresh() async {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(height: 40),
                FadeIn(child: MoviePosterLink(movie: widget.movies[index]))
              ],
            );
          }
          return FadeIn(child: MoviePosterLink(movie: widget.movies[index]));
        },
      ),
    );
  }
}
