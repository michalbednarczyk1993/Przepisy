import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../categories/data/category_repository.dart';
import '../../categories/presentation/add_category_dialog.dart';
import '../data/recipe_repository.dart';
import 'widgets/image_picker_box.dart';

class RecipeFormScreen extends ConsumerStatefulWidget {
  const RecipeFormScreen({super.key, this.id});
  final int? id;
  @override
  ConsumerState<RecipeFormScreen> createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends ConsumerState<RecipeFormScreen> {
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final ingredients = TextEditingController();
  final instructions = TextEditingController();
  final notes = TextEditingController();
  int? categoryId;
  String? imagePath;
  bool loaded = false;

  @override
  void dispose() {
    title.dispose();
    ingredients.dispose();
    instructions.dispose();
    notes.dispose();
    super.dispose();
  }

  Future<void> load() async {
    if (loaded || widget.id == null) return;
    final item = await ref.read(recipeRepositoryProvider).getById(widget.id!);
    if (item != null) {
      title.text = item.recipe.title;
      ingredients.text = item.recipe.ingredients;
      instructions.text = item.recipe.instructions;
      notes.text = item.recipe.notes ?? '';
      categoryId = item.recipe.categoryId;
      imagePath = item.recipe.imagePath;
    }
    loaded = true;
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);
    return FutureBuilder<void>(
      future: load(),
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          title: Text(widget.id == null ? 'Dodaj przepis' : 'Edytuj przepis'),
        ),
        body: categoriesAsync.when(
          data: (categories) {
            categoryId ??=
                categories
                    .where((c) => c.name == 'Do zrobienia')
                    .firstOrNull
                    ?.id ??
                (categories.isNotEmpty ? categories.first.id : null);
            return Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ImagePickerBox(
                    path: imagePath,
                    onChanged: (path) => imagePath = path,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: title,
                    decoration: const InputDecoration(
                      labelText: 'Nazwa przepisu',
                    ),
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Tytuł jest wymagany.'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    initialValue: categoryId,
                    decoration: const InputDecoration(labelText: 'Kategoria'),
                    items: categories
                        .map(
                          (c) => DropdownMenuItem(
                            value: c.id,
                            child: Text(c.name),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => categoryId = v),
                  ),
                  TextButton.icon(
                    onPressed: () => showDialog<void>(
                      context: context,
                      builder: (_) => const AddCategoryDialog(),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('Dodaj kategorię'),
                  ),
                  TextFormField(
                    controller: ingredients,
                    minLines: 4,
                    maxLines: 8,
                    decoration: const InputDecoration(labelText: 'Składniki'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: instructions,
                    minLines: 4,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      labelText: 'Przygotowanie',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: notes,
                    minLines: 2,
                    maxLines: 5,
                    decoration: const InputDecoration(labelText: 'Notatki'),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate() ||
                          categoryId == null)
                        return;
                      final draft = RecipeDraft(
                        title: title.text,
                        categoryId: categoryId!,
                        imagePath: imagePath,
                        ingredients: ingredients.text,
                        instructions: instructions.text,
                        notes: notes.text.trim().isEmpty ? null : notes.text,
                      );
                      if (widget.id == null) {
                        await ref.read(recipeRepositoryProvider).add(draft);
                      } else {
                        await ref
                            .read(recipeRepositoryProvider)
                            .updateRecipe(widget.id!, draft);
                      }
                      if (context.mounted) context.go('/recipes');
                    },
                    child: Text(
                      widget.id == null ? 'Zapisz przepis' : 'Zapisz zmiany',
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text('$e')),
        ),
      ),
    );
  }
}
