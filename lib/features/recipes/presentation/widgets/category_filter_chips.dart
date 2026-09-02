import 'package:flutter/material.dart';

import '../../../../persistence/app_database.dart';

class CategoryFilterChips extends StatelessWidget {
  const CategoryFilterChips({
    required this.categories,
    required this.selectedId,
    required this.onSelected,
    super.key,
  });
  final List<Category> categories;
  final int? selectedId;
  final ValueChanged<int?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == 0)
            return FilterChip(
              label: const Text('Wszystkie'),
              selected: selectedId == null,
              onSelected: (_) => onSelected(null),
            );
          final category = categories[index - 1];
          return FilterChip(
            label: Text(category.name),
            selected: selectedId == category.id,
            onSelected: (_) => onSelected(category.id),
          );
        },
      ),
    );
  }
}
