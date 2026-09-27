import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../persistence/app_database.dart';
import '../../categories/data/category_repository.dart';

final previewDataServiceProvider = Provider<PreviewDataService>(
  (ref) => PreviewDataService(ref.watch(databaseProvider)),
);

class PreviewDataService {
  PreviewDataService(this._db);

  final AppDatabase _db;

  Future<void> loadDemo() async {
    await _db.transaction(() async {
      await _clearAll();
      await _db.seedStarterCategories();
      final categories = await _db.select(_db.categories).get();
      final lunch = categories.singleWhere((item) => item.name == 'Obiad');
      final dessert = categories.singleWhere((item) => item.name == 'Deser');
      final now = DateTime.now();

      await _db.batch((batch) {
        batch.insertAll(_db.recipes, [
          RecipesCompanion.insert(
            title: 'Kurczak po syczuańsku',
            categoryId: lunch.id,
            ingredients: const Value(
              '500 g piersi z kurczaka\n2 łyżki sosu sojowego\n'
              '1 papryka czerwona\n2 ząbki czosnku',
            ),
            instructions: const Value(
              'Pokrój kurczaka. Wymieszaj sos. Smaż 5–6 minut i połącz '
              'składniki.',
            ),
            createdAt: now,
            updatedAt: now,
          ),
          RecipesCompanion.insert(
            title: 'Sernik domowy',
            categoryId: dessert.id,
            ingredients: const Value(
              '1 kg twarogu\n5 jajek\n200 g cukru\n100 g masła',
            ),
            instructions: const Value(
              'Połącz składniki i piecz około 60 minut w 170°C.',
            ),
            createdAt: now,
            updatedAt: now,
          ),
        ]);
      });
    });
  }

  Future<void> reset() async {
    await _db.transaction(() async {
      await _clearAll();
      await _db.seedStarterCategories();
    });
  }

  Future<void> _clearAll() async {
    await _db.delete(_db.recipes).go();
    await _db.delete(_db.categories).go();
  }
}
