import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:opennutritracker/features/create_meal/domain/entity/meal_nutriments_portion.dart';

part 'meal_nutriments_portion_dbo.g.dart';

@HiveType(typeId: 17)
@JsonSerializable()
class MealNutrimentsPerPortionDBO extends HiveObject {
  @HiveField(0)
  final double? energyKcalTotal;
  @HiveField(1)
  final double? carbohydratesTotal;
  @HiveField(2)
  final double? fatTotal;
  @HiveField(3)
  final double? proteinsTotal;
  @HiveField(4)
  final double? sugarsTotal;
  @HiveField(5)
  final double? saturatedFatTotal;
  @HiveField(6)
  final double? fiberTotal;
  @HiveField(7)
  final int? numberOfPortions;

  MealNutrimentsPerPortionDBO(
      {required this.energyKcalTotal,
      required this.carbohydratesTotal,
      required this.fatTotal,
      required this.proteinsTotal,
      required this.sugarsTotal,
      required this.saturatedFatTotal,
      required this.fiberTotal,
      required this.numberOfPortions});

  factory MealNutrimentsPerPortionDBO.fromProductNutrimentsEntity(
      MealNutrimentsEntityPortion nutriments) {
    return MealNutrimentsPerPortionDBO(
        energyKcalTotal: nutriments.energyKcalTotal,
        carbohydratesTotal: nutriments.carbohydratesTotal,
        fatTotal: nutriments.fatTotal,
        proteinsTotal: nutriments.proteinsTotal,
        sugarsTotal: nutriments.sugarsTotal,
        saturatedFatTotal: nutriments.saturatedFatTotal,
        fiberTotal: nutriments.fiberTotal,
        numberOfPortions: nutriments.numberOfPortions);
  }

  factory MealNutrimentsPerPortionDBO.fromJson(Map<String, dynamic> json) =>
      _$MealNutrimentsPerPortionDBOFromJson(json);

  Map<String, dynamic> toJson() => _$MealNutrimentsPerPortionDBOToJson(this);
}
