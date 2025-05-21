import 'package:opennutritracker/features/add_meal/domain/entity/meal_entity.dart';
import 'package:opennutritracker/features/add_meal/domain/entity/meal_nutriments_entity.dart';

class RecipeEntityFixtures {
  static final recipeOne = MealEntity(
      code: "recipe1",
      name: "Test Recipe 1",
      url: null,
      mealQuantity: 100,
      mealUnit: 'g',
      servingQuantity: 100,
      servingUnit: 'g',
      servingSize: '100g',
      nutriments: MealNutrimentsEntity(
        energyKcal100: 200,
        carbohydrates100: 20,
        fat100: 10,
        proteins100: 15,
        sugars100: 5,
        saturatedFat100: 2,
        fiber100: 3,
      ),
      source: MealSourceEntity.recipe,
      ingredients: [
        MealEntity(
          code: "ingredient1",
          name: "Ingredient 1",
          mealQuantity: 50,
          mealUnit: 'g',
          nutriments: MealNutrimentsEntity(
            energyKcal100: 100,
            carbohydrates100: 10,
            fat100: 5,
            proteins100: 7,
            sugars100: 2,
            saturatedFat100: 1,
            fiber100: 1,
          ),
          source: MealSourceEntity.custom,
        ),
        MealEntity(
          code: "ingredient2",
          name: "Ingredient 2",
          mealQuantity: 50,
          mealUnit: 'g',
          nutriments: MealNutrimentsEntity(
            energyKcal100: 100,
            carbohydrates100: 10,
            fat100: 5,
            proteins100: 8,
            sugars100: 3,
            saturatedFat100: 1,
            fiber100: 2,
          ),
          source: MealSourceEntity.custom,
        ),
      ]);

  static final recipeTwo = MealEntity(
      code: "recipe2",
      name: "Test Recipe 2",
      url: null,
      mealQuantity: 200,
      mealUnit: 'g',
      servingQuantity: 200,
      servingUnit: 'g',
      servingSize: '200g',
      nutriments: MealNutrimentsEntity(
        energyKcal100: 150,
        carbohydrates100: 15,
        fat100: 8,
        proteins100: 12,
        sugars100: 4,
        saturatedFat100: 1.5,
        fiber100: 2,
      ),
      source: MealSourceEntity.recipe,
      ingredients: [
        MealEntity(
          code: "ingredient3",
          name: "Ingredient 3",
          mealQuantity: 100,
          mealUnit: 'g',
          nutriments: MealNutrimentsEntity(
            energyKcal100: 75,
            carbohydrates100: 8,
            fat100: 4,
            proteins100: 6,
            sugars100: 2,
            saturatedFat100: 0.8,
            fiber100: 1,
          ),
          source: MealSourceEntity.custom,
        ),
        MealEntity(
          code: "ingredient4",
          name: "Ingredient 4",
          mealQuantity: 100,
          mealUnit: 'g',
          nutriments: MealNutrimentsEntity(
            energyKcal100: 75,
            carbohydrates100: 7,
            fat100: 4,
            proteins100: 6,
            sugars100: 2,
            saturatedFat100: 0.7,
            fiber100: 1,
          ),
          source: MealSourceEntity.custom,
        ),
      ]);
}