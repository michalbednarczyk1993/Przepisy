class Recipe {
  const Recipe({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.ingredients,
    required this.instructions,
    required this.createdAt,
    required this.updatedAt,
    this.imagePath,
    this.notes,
  });

  final int id;
  final String title;
  final int categoryId;
  final String? imagePath;
  final String ingredients;
  final String instructions;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
}

bool recipeMatchesFilters(Recipe recipe, {int? categoryId, String query = ''}) {
  final matchesCategory = categoryId == null || recipe.categoryId == categoryId;
  final normalizedQuery = query.trim().toLowerCase();
  final matchesQuery =
      normalizedQuery.isEmpty ||
      recipe.title.toLowerCase().contains(normalizedQuery);
  return matchesCategory && matchesQuery;
}
