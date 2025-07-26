import 'package:flutter/material.dart';
import 'package:opennutritracker/core/data/data_source/macro_goal_dbo.dart';

class MacroGoalEntity {
  final String id;
  final DateTime date;
  final DateTime updatedAt;
  final double weight;

  final double oldCarbsGoal;
  final double oldFatsGoal;
  final double oldProteinsGoal;

  final double newCarbsGoal;
  final double newFatsGoal;
  final double newProteinsGoal;

  MacroGoalEntity({
    required this.id,
    required this.date,
    required this.weight,
    required this.updatedAt,
    required this.oldCarbsGoal,
    required this.oldFatsGoal,
    required this.oldProteinsGoal,
    required this.newCarbsGoal,
    required this.newFatsGoal,
    required this.newProteinsGoal,
  });

  /// Conversion depuis un DBO Hive
  factory MacroGoalEntity.fromDbo(MacroGoalDbo dbo) {
    return MacroGoalEntity(
      id: dbo.id,
      date: dbo.date,
      updatedAt: dbo.updatedAt,
      weight: dbo.weight,
      oldCarbsGoal: dbo.oldCarbsGoal,
      oldFatsGoal: dbo.oldFatsGoal,
      oldProteinsGoal: dbo.oldProteinsGoal,
      newCarbsGoal: dbo.newCarbsGoal,
      newFatsGoal: dbo.newFatsGoal,
      newProteinsGoal: dbo.newProteinsGoal,
    );
  }

  /// Conversion vers DBO Hive
  MacroGoalDbo toDbo() {
    return MacroGoalDbo(
      id,
      date,
      updatedAt,
      weight,
      oldCarbsGoal,
      oldFatsGoal,
      oldProteinsGoal,
      newCarbsGoal,
      newFatsGoal,
      newProteinsGoal,
    );
  }
}
