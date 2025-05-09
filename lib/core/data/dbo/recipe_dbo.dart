import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:opennutritracker/core/data/dbo/meal_nutriments_portion_dbo.dart';
import 'package:opennutritracker/features/create_meal/domain/entity/recipe.dart';
part 'recipe_dbo.g.dart';

@HiveType(typeId: 16)
@JsonSerializable()
class RecipeDBO extends HiveObject {
  @HiveField(0)
  final String? code;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final MealNutrimentsPerPortionDBO nutriments;

  RecipeDBO({required this.code, required this.name, required this.nutriments});

  factory RecipeDBO.fromReceipe(Recipe recipe) => RecipeDBO(
      code: recipe.code,
      name: recipe.name,
      nutriments: MealNutrimentsPerPortionDBO.fromProductNutrimentsEntity(
          recipe.nutriments));

  factory RecipeDBO.fromJson(Map<String, dynamic> json) =>
      _$RecipeDBOFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeDBOToJson(this);
}
