import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/category_repository.dart';

class AddCategoryDialog extends ConsumerStatefulWidget {
  const AddCategoryDialog({super.key});
  @override
  ConsumerState<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends ConsumerState<AddCategoryDialog> {
  final controller = TextEditingController();
  String? error;

  @override
  void dispose() { controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Dodaj kategorię'),
      content: TextField(controller: controller, decoration: InputDecoration(labelText: 'Nazwa kategorii', errorText: error)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Anuluj')),
        FilledButton(onPressed: () async {
          try { await ref.read(categoryRepositoryProvider).add(controller.text); if (context.mounted) Navigator.pop(context); }
          catch (e) { setState(() => error = e is ArgumentError ? 'Nazwa nie może być pusta.' : 'Kategoria już istnieje.'); }
        }, child: const Text('Dodaj')),
      ],
    );
  }
}
