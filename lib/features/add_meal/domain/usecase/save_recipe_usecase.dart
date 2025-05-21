import 'package:opennutritracker/features/add_meal/domain/entity/meal_entity.dart';
import 'package:opennutritracker/features/add_meal/domain/repository/recipe_repository.dart';

class SaveRecipeUsecase {
  final RecipeRepository _recipeRepository;

  SaveRecipeUsecase(this._recipeRepository);

  Future<bool> saveRecipe(MealEntity recipe) async {
    return await _recipeRepository.saveRecipe(recipe);
  }
}