import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../persistence/app_database.dart';
import '../../categories/data/category_repository.dart';

final recipeRepositoryProvider = Provider<RecipeRepository>((ref) => RecipeRepository(ref.watch(databaseProvider)));
final recipesProvider = StreamProvider<List<RecipeWithCategory>>((ref) => ref.watch(recipeRepositoryProvider).watchAll());

class RecipeWithCategory {
  const RecipeWithCategory({required this.recipe, required this.category});
  final Recipe recipe;
  final Category category;
}

class RecipeDraft {
  const RecipeDraft({required this.title, required this.categoryId, this.imagePath, this.ingredients = '', this.instructions = '', this.notes});
  final String title;
  final int categoryId;
  final String? imagePath;
  final String ingredients;
  final String instructions;
  final String? notes;
}

class RecipeRepository {
  RecipeRepository(this._db);
  final AppDatabase _db;

  Stream<List<RecipeWithCategory>> watchAll() {
    final query = _db.select(_db.recipes).join([innerJoin(_db.categories, _db.categories.id.equalsExp(_db.recipes.categoryId))])
      ..orderBy([OrderingTerm.desc(_db.recipes.updatedAt)]);
    return query.watch().map((rows) => rows.map((row) => RecipeWithCategory(recipe: row.readTable(_db.recipes), category: row.readTable(_db.categories))).toList());
  }

  Future<RecipeWithCategory?> getById(int id) async {
    final query = _db.select(_db.recipes).join([innerJoin(_db.categories, _db.categories.id.equalsExp(_db.recipes.categoryId))])
      ..where(_db.recipes.id.equals(id));
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return RecipeWithCategory(recipe: row.readTable(_db.recipes), category: row.readTable(_db.categories));
  }

  Future<int> add(RecipeDraft draft) {
    final now = DateTime.now();
    return _db.into(_db.recipes).insert(RecipesCompanion.insert(
          title: draft.title.trim(),
          categoryId: draft.categoryId,
          imagePath: Value(draft.imagePath),
          ingredients: Value(draft.ingredients),
          instructions: Value(draft.instructions),
          notes: Value(draft.notes),
          createdAt: now,
          updatedAt: now,
        ));
  }

  Future<void> updateRecipe(int id, RecipeDraft draft) async {
    await (_db.update(_db.recipes)..where((r) => r.id.equals(id))).write(RecipesCompanion(
      title: Value(draft.title.trim()),
      categoryId: Value(draft.categoryId),
      imagePath: Value(draft.imagePath),
      ingredients: Value(draft.ingredients),
      instructions: Value(draft.instructions),
      notes: Value(draft.notes),
      updatedAt: Value(DateTime.now()),
    ));
  }

  Future<void> delete(int id) => (_db.delete(_db.recipes)..where((r) => r.id.equals(id))).go();
}
