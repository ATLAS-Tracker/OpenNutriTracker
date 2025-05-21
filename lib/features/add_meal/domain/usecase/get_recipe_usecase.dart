import 'package:opennutritracker/features/add_meal/domain/entity/meal_entity.dart';
import 'package:opennutritracker/features/add_meal/domain/repository/recipe_repository.dart';

class GetRecipeUsecase {
  final RecipeRepository _recipeRepository;

  GetRecipeUsecase(this._recipeRepository);

  Future<MealEntity?> getRecipeById(String id) async {
    return await _recipeRepository.getRecipeById(id);
  }

  Future<List<MealEntity>> getAllRecipes() async {
    return await _recipeRepository.getAllRecipes();
  }

  Future<List<MealEntity>> searchRecipes(String searchString) async {
    return await _recipeRepository.searchRecipes(searchString);
  }
}