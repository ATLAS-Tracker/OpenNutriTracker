import 'package:flutter_test/flutter_test.dart';
import 'package:opennutritracker/core/data/dbo/meal_dbo.dart';
import 'package:opennutritracker/features/add_meal/domain/entity/meal_entity.dart';
import 'package:opennutritracker/features/add_meal/domain/entity/meal_nutriments_entity.dart';

void main() {
  group('MealType Tests', () {
    test('MealEntity should have default meal type', () {
      final mealEntity = MealEntity(
        code: '123',
        name: 'Test Meal',
        url: 'https://example.com',
        mealQuantity: '100',
        mealUnit: 'g',
        servingQuantity: 100,
        servingUnit: 'g',
        servingSize: '100g',
        nutriments: MealNutrimentsEntity.empty(),
        source: MealSourceEntity.custom,
      );
      
      expect(mealEntity.mealType, MealType.meal);
    });
    
    test('MealEntity should accept recipe type', () {
      final mealEntity = MealEntity(
        code: '123',
        name: 'Test Recipe',
        url: 'https://example.com',
        mealQuantity: '100',
        mealUnit: 'g',
        servingQuantity: 100,
        servingUnit: 'g',
        servingSize: '100g',
        nutriments: MealNutrimentsEntity.empty(),
        source: MealSourceEntity.custom,
        mealType: MealType.recipe,
      );
      
      expect(mealEntity.mealType, MealType.recipe);
      expect(mealEntity.mealType.isRecipe, true);
    });
    
    test('MealDBO should store meal type', () {
      final mealEntity = MealEntity(
        code: '123',
        name: 'Test Recipe',
        url: 'https://example.com',
        mealQuantity: '100',
        mealUnit: 'g',
        servingQuantity: 100,
        servingUnit: 'g',
        servingSize: '100g',
        nutriments: MealNutrimentsEntity.empty(),
        source: MealSourceEntity.custom,
        mealType: MealType.recipe,
      );
      
      final mealDBO = MealDBO.fromMealEntity(mealEntity);
      expect(mealDBO.mealType, 'recipe');
    });
    
    test('MealEntity from MealDBO should restore meal type', () {
      final originalEntity = MealEntity(
        code: '123',
        name: 'Test Recipe',
        url: 'https://example.com',
        mealQuantity: '100',
        mealUnit: 'g',
        servingQuantity: 100,
        servingUnit: 'g',
        servingSize: '100g',
        nutriments: MealNutrimentsEntity.empty(),
        source: MealSourceEntity.custom,
        mealType: MealType.recipe,
      );
      
      final mealDBO = MealDBO.fromMealEntity(originalEntity);
      final restoredEntity = MealEntity.fromMealDBO(mealDBO);
      
      expect(restoredEntity.mealType, MealType.recipe);
      expect(restoredEntity.mealType.isRecipe, true);
    });
    
    test('isRecipe and isMeal getters work correctly', () {
      final mealEntity = MealEntity(
        code: '123',
        name: 'Test Meal',
        url: 'https://example.com',
        mealQuantity: '100',
        mealUnit: 'g',
        servingQuantity: 100,
        servingUnit: 'g',
        servingSize: '100g',
        nutriments: MealNutrimentsEntity.empty(),
        source: MealSourceEntity.custom,
        mealType: MealType.meal,
      );
      
      final recipeEntity = MealEntity(
        code: '456',
        name: 'Test Recipe',
        url: 'https://example.com',
        mealQuantity: '100',
        mealUnit: 'g',
        servingQuantity: 100,
        servingUnit: 'g',
        servingSize: '100g',
        nutriments: MealNutrimentsEntity.empty(),
        source: MealSourceEntity.custom,
        mealType: MealType.recipe,
      );
      
      expect(mealEntity.mealType.isMeal, true);
      expect(mealEntity.mealType.isRecipe, false);
      
      expect(recipeEntity.mealType.isMeal, false);
      expect(recipeEntity.mealType.isRecipe, true);
    });
  });
}