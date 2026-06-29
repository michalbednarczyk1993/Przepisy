import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/empty_state.dart';
import '../data/recipe_repository.dart';

class RecipeDetailScreen extends ConsumerWidget {
  const RecipeDetailScreen({required this.id, super.key});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<RecipeWithCategory?>(
      future: ref.watch(recipeRepositoryProvider).getById(id),
      builder: (context, snapshot) {
        final item = snapshot.data;
        if (snapshot.connectionState != ConnectionState.done) return const Scaffold(body: Center(child: CircularProgressIndicator()));
        if (item == null) return const Scaffold(body: EmptyState(message: 'Nie znaleziono przepisu.'));
        final recipe = item.recipe;
        return Scaffold(
          appBar: AppBar(actions: [IconButton(onPressed: () => context.push('/recipes/$id/edit'), icon: const Icon(Icons.edit))]),
          body: ListView(padding: const EdgeInsets.only(bottom: 24), children: [
            if (recipe.imagePath == null)
              Container(height: 220, color: Colors.green.shade50, child: const Icon(Icons.restaurant, size: 72))
            else
              Image.file(File(recipe.imagePath!), height: 240, fit: BoxFit.cover),
            Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(recipe.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Chip(label: Text(item.category.name), avatar: const Icon(Icons.category_outlined)),
              const SizedBox(height: 16),
              _Section(title: 'Składniki', body: recipe.ingredients.isEmpty ? 'Brak składników.' : recipe.ingredients),
              _Section(title: 'Przygotowanie', body: recipe.instructions.isEmpty ? 'Brak opisu przygotowania.' : recipe.instructions),
              if (recipe.notes?.isNotEmpty ?? false) _Section(title: 'Notatki', body: recipe.notes!),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(child: OutlinedButton.icon(onPressed: () => context.push('/recipes/$id/edit'), icon: const Icon(Icons.edit), label: const Text('Edytuj'))),
                const SizedBox(width: 12),
                Expanded(child: OutlinedButton.icon(onPressed: () async {
                  final confirmed = await showConfirmDialog(context, title: 'Usunąć przepis?', message: 'Tej operacji nie można cofnąć.');
                  if (confirmed) { await ref.read(recipeRepositoryProvider).delete(id); if (context.mounted) context.go('/recipes'); }
                }, icon: const Icon(Icons.delete_outline), label: const Text('Usuń'))),
              ]),
            ])),
          ]),
        );
      },
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(body),
      ]),
    );
  }
}
