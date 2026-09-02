import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../persistence/app_database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepository(ref.watch(databaseProvider));
});

final categoriesProvider = StreamProvider<List<Category>>((ref) {
  return ref.watch(categoryRepositoryProvider).watchAll();
});

class CategoryRepository {
  CategoryRepository(this._db);

  final AppDatabase _db;

  Stream<List<Category>> watchAll() {
    return (_db.select(
      _db.categories,
    )..orderBy([(c) => OrderingTerm(expression: c.name)])).watch();
  }

  Future<List<Category>> getAll() => (_db.select(
    _db.categories,
  )..orderBy([(c) => OrderingTerm(expression: c.name)])).get();

  Future<Category?> findByNameInsensitive(String name) async {
    final normalized = name.trim().toLowerCase();
    final rows = await _db.select(_db.categories).get();
    for (final category in rows) {
      if (category.name.trim().toLowerCase() == normalized) {
        return category;
      }
    }
    return null;
  }

  Future<int> add(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('Nazwa kategorii jest wymagana.');
    }
    if (await findByNameInsensitive(trimmed) != null) {
      throw StateError('Kategoria już istnieje.');
    }
    return _db
        .into(_db.categories)
        .insert(
          CategoriesCompanion.insert(name: trimmed, createdAt: DateTime.now()),
        );
  }

  Future<bool> deleteIfUnused(int id) async {
    final count = await (_db.select(
      _db.recipes,
    )..where((r) => r.categoryId.equals(id))).get();
    if (count.isNotEmpty) return false;
    await (_db.delete(_db.categories)..where((c) => c.id.equals(id))).go();
    return true;
  }
}
