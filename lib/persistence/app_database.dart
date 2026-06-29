import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/categories_table.dart';
import 'tables/recipes_table.dart';

part 'app_database.g.dart';

const starterCategoryNames = [
  'Śniadanie',
  'Obiad',
  'Kolacja',
  'Deser',
  'Przekąski',
  'Azjatyckie',
  'Do zrobienia',
];

@DriftDatabase(tables: [Categories, Recipes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await seedStarterCategories();
        },
      );

  Future<void> seedStarterCategories() async {
    final now = DateTime.now();
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        categories,
        starterCategoryNames.map((name) => CategoriesCompanion.insert(name: name, createdAt: now)).toList(),
      );
    });
  }
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'recipe_book');
}
