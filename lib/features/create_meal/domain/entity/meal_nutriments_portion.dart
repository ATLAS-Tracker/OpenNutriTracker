import 'package:equatable/equatable.dart';
import 'package:opennutritracker/core/data/dbo/meal_nutriments_portion_dbo.dart';

class MealNutrimentsEntityPortion extends Equatable {
  final double? energyKcalTotal;
  final double? carbohydratesTotal;
  final double? fatTotal;
  final double? proteinsTotal;
  final double? sugarsTotal;
  final double? saturatedFatTotal;
  final double? fiberTotal;
  final int? numberOfPortions;

  double? get energyPerPortion => _getValuePerPortion(energyKcalTotal);

  double? get carbohydratesPerPortion =>
      _getValuePerPortion(carbohydratesTotal);

  double? get fatPerPortion => _getValuePerPortion(fatTotal);

  double? get proteinsPerPortion => _getValuePerPortion(proteinsTotal);

  const MealNutrimentsEntityPortion(
      {required this.energyKcalTotal,
      required this.carbohydratesTotal,
      required this.fatTotal,
      required this.proteinsTotal,
      required this.sugarsTotal,
      required this.saturatedFatTotal,
      required this.fiberTotal,
      required this.numberOfPortions});

  factory MealNutrimentsEntityPortion.empty() =>
      const MealNutrimentsEntityPortion(
          energyKcalTotal: null,
          carbohydratesTotal: null,
          fatTotal: null,
          proteinsTotal: null,
          sugarsTotal: null,
          saturatedFatTotal: null,
          fiberTotal: null,
          numberOfPortions: 1);

  factory MealNutrimentsEntityPortion.fromMealNutrimentsDBO(
      MealNutrimentsPerPortionDBO nutriments) {
    return MealNutrimentsEntityPortion(
        energyKcalTotal: nutriments.energyKcalTotal,
        carbohydratesTotal: nutriments.carbohydratesTotal,
        fatTotal: nutriments.fatTotal,
        proteinsTotal: nutriments.proteinsTotal,
        sugarsTotal: nutriments.sugarsTotal,
        saturatedFatTotal: nutriments.saturatedFatTotal,
        fiberTotal: nutriments.fiberTotal,
        numberOfPortions: nutriments.numberOfPortions);
  }

  double? _getValuePerPortion(double? valueTotal) {
    if (valueTotal != null && numberOfPortions == 0) {
      return valueTotal / 1;
    } else if (valueTotal != null) {
      return valueTotal / numberOfPortions!;
    } else {
      return null;
    }
  }

  @override
  List<Object?> get props =>
      [energyKcalTotal, carbohydratesTotal, fatTotal, proteinsTotal];
}
