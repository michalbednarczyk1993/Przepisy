import 'dart:io';

import 'package:flutter/material.dart';

import '../../data/recipe_repository.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({required this.item, required this.onTap, super.key});
  final RecipeWithCategory item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final imagePath = item.recipe.imagePath;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: imagePath == null
                    ? Container(
                        width: 96,
                        height: 96,
                        color: Colors.green.shade50,
                        child: const Icon(Icons.restaurant, size: 36),
                      )
                    : Image.file(
                        File(imagePath),
                        width: 96,
                        height: 96,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.recipe.title,
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Text(item.category.name),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
