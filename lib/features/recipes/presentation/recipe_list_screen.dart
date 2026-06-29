import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/empty_state.dart';
import '../../categories/data/category_repository.dart';
import '../data/recipe_repository.dart';
import '../presentation/widgets/category_filter_chips.dart';
import '../presentation/widgets/recipe_card.dart';

class RecipeListScreen extends ConsumerStatefulWidget {
  const RecipeListScreen({super.key});
  @override
  ConsumerState<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends ConsumerState<RecipeListScreen> {
  int? categoryId;
  String query = '';

  @override
  Widget build(BuildContext context) {
    final recipes = ref.watch(recipesProvider);
    final categories = ref.watch(categoriesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Moje przepisy')),
      floatingActionButton: FloatingActionButton(onPressed: () => context.push('/recipes/new'), child: const Icon(Icons.add)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Szukaj przepisu...'), onChanged: (value) => setState(() => query = value)),
          const SizedBox(height: 12),
          categories.when(data: (data) => CategoryFilterChips(categories: data, selectedId: categoryId, onSelected: (id) => setState(() => categoryId = id)), loading: () => const LinearProgressIndicator(), error: (e, s) => Text('$e')),
          const SizedBox(height: 12),
          Expanded(child: recipes.when(
            data: (items) {
              final filtered = items.where((item) {
                final matchesCategory = categoryId == null || item.recipe.categoryId == categoryId;
                final matchesQuery = query.trim().isEmpty || item.recipe.title.toLowerCase().contains(query.trim().toLowerCase());
                return matchesCategory && matchesQuery;
              }).toList();
              if (filtered.isEmpty) return const EmptyState(message: 'Brak przepisów. Dodaj pierwszy przepis.');
              return ListView.separated(itemCount: filtered.length, separatorBuilder: (_, __) => const SizedBox(height: 8), itemBuilder: (context, i) => RecipeCard(item: filtered[i], onTap: () => context.push('/recipes/${filtered[i].recipe.id}')));
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => EmptyState(message: 'Nie udało się wczytać przepisów: $e'),
          )),
        ]),
      ),
    );
  }
}
