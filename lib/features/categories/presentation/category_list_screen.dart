import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/empty_state.dart';
import '../data/category_repository.dart';
import 'add_category_dialog.dart';

class CategoryListScreen extends ConsumerWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Kategorie')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog<void>(
          context: context,
          builder: (_) => const AddCategoryDialog(),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Dodaj kategorię'),
      ),
      body: categories.when(
        data: (items) => items.isEmpty
            ? const EmptyState(message: 'Brak kategorii.')
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) => ListTile(
                  title: Text(items[index].name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () async {
                      final ok = await ref
                          .read(categoryRepositoryProvider)
                          .deleteIfUnused(items[index].id);
                      if (!ok && context.mounted)
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Ta kategoria ma przypisane przepisy.',
                            ),
                          ),
                        );
                    },
                  ),
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) =>
            EmptyState(message: 'Nie udało się wczytać kategorii: $e'),
      ),
    );
  }
}
