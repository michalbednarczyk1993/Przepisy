import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book/features/preview/data/preview_data_service.dart';
import 'package:recipe_book/persistence/app_database.dart';

void main() {
  late AppDatabase database;
  late PreviewDataService service;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    service = PreviewDataService(database);
  });

  tearDown(() => database.close());

  test('demo data can be loaded and reset deterministically', () async {
    await service.loadDemo();

    final demoRecipes = await database.select(database.recipes).get();
    expect(
      demoRecipes.map((recipe) => recipe.title),
      containsAll(['Kurczak po syczuańsku', 'Sernik domowy']),
    );

    await service.reset();

    expect(await database.select(database.recipes).get(), isEmpty);
    final categories = await database.select(database.categories).get();
    expect(categories, hasLength(starterCategoryNames.length));
    expect(
      categories.map((category) => category.name),
      unorderedEquals(starterCategoryNames),
    );
  });
}
