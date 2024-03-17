import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imagePath;
  const ImageCard({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, 10),
        ),
      ],
    );

    return DecoratedBox(
      decoration: decoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return const DecoratedBox(
                decoration: BoxDecoration(color: Colors.black12),
              );
            }

            return FadeIn(
              duration: const Duration(seconds: 1),
              child: child,
            );
          },
        ),
      ),
    );
  }
}
