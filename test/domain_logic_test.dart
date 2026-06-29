import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_book/features/categories/domain/category.dart';
import 'package:recipe_book/features/recipes/domain/recipe.dart';

void main() {
  test('category names are unique case-insensitively', () {
    final categories = [RecipeCategory(id: 1, name: 'Obiad', createdAt: DateTime(2026))];
    expect(isUniqueCategoryName(' obiad ', categories), isFalse);
    expect(isUniqueCategoryName('Deser', categories), isTrue);
  });

  test('recipe filter matches category and title query', () {
    final recipe = Recipe(id: 1, title: 'Kurczak po syczuańsku', categoryId: 2, ingredients: '', instructions: '', createdAt: DateTime(2026), updatedAt: DateTime(2026));
    expect(recipeMatchesFilters(recipe, categoryId: 2, query: 'kurczak'), isTrue);
    expect(recipeMatchesFilters(recipe, categoryId: 3, query: 'kurczak'), isFalse);
    expect(recipeMatchesFilters(recipe, categoryId: 2, query: 'sernik'), isFalse);
  });
}
