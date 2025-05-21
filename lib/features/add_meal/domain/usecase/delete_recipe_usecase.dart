import 'package:opennutritracker/features/add_meal/domain/repository/recipe_repository.dart';

class DeleteRecipeUsecase {
  final RecipeRepository _recipeRepository;

  DeleteRecipeUsecase(this._recipeRepository);

  Future<bool> deleteRecipe(String id) async {
    return await _recipeRepository.deleteRecipe(id);
  }
}