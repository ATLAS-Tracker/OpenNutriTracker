import 'package:equatable/equatable.dart';
import 'package:opennutritracker/core/data/dbo/intake_recipe_dbo.dart';
import 'package:opennutritracker/core/domain/entity/intake_type_entity.dart';
import 'package:opennutritracker/features/create_meal/domain/entity/recipe.dart';

class IntakeRecipeEntity extends Equatable {
  final String id;
  final String unit;
  final double amount;
  final IntakeTypeEntity type;
  final Recipe recipe;
  final DateTime dateTime;

  const IntakeRecipeEntity(
      {required this.id,
      required this.unit,
      required this.amount,
      required this.type,
      required this.recipe,
      required this.dateTime});

  factory IntakeRecipeEntity.fromIntakeDBO(IntakeRecipeDBO intakeRecipeDBO) {
    return IntakeRecipeEntity(
        id: intakeRecipeDBO.id,
        unit: intakeRecipeDBO.unit,
        amount: intakeRecipeDBO.amount,
        type: IntakeTypeEntity.fromIntakeTypeDBO(intakeRecipeDBO.type),
        recipe: Recipe.fromRecipeDBO(intakeRecipeDBO.recipe),
        dateTime: intakeRecipeDBO.dateTime);
  }

  double get totalKcal => amount * (recipe.nutriments.energyPerPortion ?? 0);

  double get totalCarbsGram =>
      amount * (recipe.nutriments.carbohydratesPerPortion ?? 0);

  double get totalFatsGram => amount * (recipe.nutriments.fatPerPortion ?? 0);

  double get totalProteinsGram =>
      amount * (recipe.nutriments.proteinsPerPortion ?? 0);

  @override
  List<Object?> get props => [id, unit, amount, type, dateTime];
}

extension IntakeRecipeEntityCopy on IntakeRecipeEntity {
  IntakeRecipeEntity copyWith({
    String? id,
    String? unit,
    double? amount,
    IntakeTypeEntity? type,
    Recipe? recipe,
    DateTime? dateTime,
  }) {
    return IntakeRecipeEntity(
      id: id ?? this.id,
      unit: unit ?? this.unit,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      recipe: recipe ?? this.recipe,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
