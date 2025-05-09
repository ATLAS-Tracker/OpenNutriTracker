import 'package:equatable/equatable.dart';
import 'package:opennutritracker/core/utils/id_generator.dart';
import 'package:opennutritracker/features/create_meal/domain/entity/meal_nutriments_portion.dart';
import 'package:opennutritracker/core/data/dbo/recipe_dbo.dart';

class Recipe extends Equatable {
  final String? code;
  final String? name;
  final MealNutrimentsEntityPortion nutriments;

  const Recipe(
      {required this.code, required this.name, required this.nutriments});

  factory Recipe.empty() => Recipe(
      code: IdGenerator.getUniqueID(),
      name: null,
      nutriments: MealNutrimentsEntityPortion.empty());

  factory Recipe.fromRecipeDBO(RecipeDBO recipeDBO) => Recipe(
      code: recipeDBO.code,
      name: recipeDBO.name,
      nutriments: MealNutrimentsEntityPortion.fromMealNutrimentsDBO(
          recipeDBO.nutriments));

  @override
  List<Object?> get props => [code, name];
}
