import 'dart:io';

import 'package:logging/logging.dart';
import 'package:opennutritracker/core/data/repository/recipe_repository.dart';

class DeleteRecipeUsecase {
  final RecipeRepository _recipeRepository;
  final log = Logger('DeleteRecipeUsecase');

  DeleteRecipeUsecase(this._recipeRepository);

  Future<void> deleteRecipe(String recipeId) async {
    final recipe = await _recipeRepository.getRecipeByKey(recipeId);

    if (recipe != null) {
      final paths = [
        recipe.meal.url,
        recipe.meal.thumbnailImageUrl,
        recipe.meal.mainImageUrl,
      ];
      for (final path in paths) {
        if (path != null && !path.startsWith('http')) {
          final file = File(path);
          if (await file.exists()) {
            try {
              await file.delete();
              log.fine('Deleted local file: $path');
            } catch (e) {
              log.warning('Failed to delete local file $path: $e');
            }
          }
        }
      }
    }

    await _recipeRepository.deleteRecipe(recipeId);
  }
}
