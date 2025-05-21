import 'package:opennutritracker/features/add_meal/domain/entity/meal_entity.dart';

abstract class RecipeRepository {
  Future<MealEntity?> getRecipeById(String id);
  Future<List<MealEntity>> getAllRecipes();
  Future<List<MealEntity>> searchRecipes(String searchString);
  Future<bool> deleteRecipe(String id);
  Future<bool> saveRecipe(MealEntity recipe);
}