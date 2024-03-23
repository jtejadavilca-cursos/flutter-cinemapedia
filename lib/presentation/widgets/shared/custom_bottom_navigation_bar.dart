import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBarWidget extends StatelessWidget {
  static const _views = [
    '/',
    '/categories',
    '/favorites',
  ];

  const CustomBottomNavigationBarWidget({super.key});

  int _getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).fullPath ?? '/';

    for (int i = 0; i < _views.length; i++) {
      if (location == _views[i]) return i;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: _getCurrentIndex(context),
      onTap: (index) => context.go(_views[index]),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Categories',
        ),
      ],
    );
  }
}
