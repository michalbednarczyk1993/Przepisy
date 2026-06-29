import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/categories/presentation/category_list_screen.dart';
import '../../features/recipes/presentation/recipe_detail_screen.dart';
import '../../features/recipes/presentation/recipe_form_screen.dart';
import '../../features/recipes/presentation/recipe_list_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/recipes',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(path: '/recipes', builder: (context, state) => const RecipeListScreen()),
        GoRoute(path: '/categories', builder: (context, state) => const CategoryListScreen()),
      ],
    ),
    GoRoute(path: '/recipes/new', builder: (context, state) => const RecipeFormScreen()),
    GoRoute(path: '/recipes/:id', builder: (context, state) => RecipeDetailScreen(id: int.parse(state.pathParameters['id']!))),
    GoRoute(path: '/recipes/:id/edit', builder: (context, state) => RecipeFormScreen(id: int.parse(state.pathParameters['id']!))),
  ],
);

class AppShell extends StatelessWidget {
  const AppShell({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final index = location.startsWith('/categories') ? 1 : 0;
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => context.go(value == 0 ? '/recipes' : '/categories'),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Przepisy'),
          NavigationDestination(icon: Icon(Icons.category_outlined), selectedIcon: Icon(Icons.category), label: 'Kategorie'),
        ],
      ),
    );
  }
}
