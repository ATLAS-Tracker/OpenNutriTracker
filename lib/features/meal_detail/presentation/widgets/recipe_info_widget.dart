import 'package:flutter/material.dart';
import 'package:opennutritracker/features/add_meal/domain/entity/meal_entity.dart';
import 'package:opennutritracker/generated/l10n.dart';

/// A widget that displays recipe-specific information
class RecipeInfoWidget extends StatelessWidget {
  final MealEntity meal;

  const RecipeInfoWidget({
    Key? key,
    required this.meal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the enum instead of the magic string "recipe"
    if (meal.mealType == MealType.recipe) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).recipeLabel,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          // Recipe-specific UI elements would go here
          Text(
            S.of(context).recipeIngredientsLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          // Recipe ingredients would be displayed here
          const SizedBox(height: 16),
          Text(
            S.of(context).recipeInstructionsLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          // Recipe instructions would be displayed here
        ],
      );
    } else {
      // Return an empty container if it's not a recipe
      return const SizedBox.shrink();
    }
  }
}

// Alternative implementation using the isRecipe getter
class RecipeInfoWidgetAlternative extends StatelessWidget {
  final MealEntity meal;

  const RecipeInfoWidgetAlternative({
    Key? key,
    required this.meal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the isRecipe getter instead of comparing with the enum directly
    if (meal.mealType.isRecipe) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).recipeLabel,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          // Recipe-specific UI elements would go here
        ],
      );
    } else {
      // Return an empty container if it's not a recipe
      return const SizedBox.shrink();
    }
  }
}