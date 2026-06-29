class RecipeCategory {
  const RecipeCategory({required this.id, required this.name, required this.createdAt});

  final int id;
  final String name;
  final DateTime createdAt;
}

bool isUniqueCategoryName(String name, Iterable<RecipeCategory> categories) {
  final normalized = name.trim().toLowerCase();
  return normalized.isNotEmpty && categories.every((c) => c.name.trim().toLowerCase() != normalized);
}
