import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'macro_goal_dbo.g.dart';

@HiveType(typeId: 20)
@JsonSerializable()
class MacroGoalDbo extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final DateTime updatedAt;

  @HiveField(3)
  final double weight;

  @HiveField(4)
  final double oldCarbsGoal;

  @HiveField(5)
  final double oldFatsGoal;

  @HiveField(6)
  final double oldProteinsGoal;

  @HiveField(7)
  final double newCarbsGoal;

  @HiveField(8)
  final double newFatsGoal;

  @HiveField(9)
  final double newProteinsGoal;

  MacroGoalDbo(
    this.id,
    this.date,
    this.updatedAt,
    this.weight,
    this.oldCarbsGoal,
    this.oldFatsGoal,
    this.oldProteinsGoal,
    this.newCarbsGoal,
    this.newFatsGoal,
    this.newProteinsGoal,
  );

  factory MacroGoalDbo.fromJson(Map<String, dynamic> json) =>
      _$MacroGoalDboFromJson(json);

  Map<String, dynamic> toJson() => _$MacroGoalDboToJson(this);
}
