import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:opennutritracker/core/data/dbo/intake_recipe_dbo.dart';
import 'package:opennutritracker/core/data/dbo/intake_type_dbo.dart';

class IntakeRecipeDataSource {
  final log = Logger('IntakeRecipeDataSource');
  final Box<IntakeRecipeDBO> _intakeRecipeBox;

  IntakeRecipeDataSource(this._intakeRecipeBox);

  Future<void> addRecipeIntake(IntakeRecipeDBO intakeRecipeDBO) async {
    log.fine('Adding new recipe intake item to db');
    _intakeRecipeBox.add(intakeRecipeDBO);
  }

  Future<void> addAllRecipeIntakes(
      List<IntakeRecipeDBO> intakeRecipeDBOList) async {
    log.fine('Adding new recipe intake items to db');
    _intakeRecipeBox.addAll(intakeRecipeDBOList);
  }

  Future<void> deleteRecipeIntakeFromId(String intakeId) async {
    log.fine('Deleting recipe intake item from db');
    _intakeRecipeBox.values
        .where((dbo) => dbo.id == intakeId)
        .toList()
        .forEach((element) {
      element.delete();
    });
  }

  Future<IntakeRecipeDBO?> updateRecipeIntake(
      String intakeId, Map<String, dynamic> fields) async {
    log.fine(
        'Updating recipe intake $intakeId with fields ${fields.toString()} in db');
    var intakeObject = _intakeRecipeBox.values.indexed
        .where((indexedDbo) => indexedDbo.$2.id == intakeId)
        .firstOrNull;
    if (intakeObject == null) {
      log.fine('Cannot update recipe intake $intakeId as it is non existent');
      return null;
    }
    intakeObject.$2.amount = fields['amount'] ?? intakeObject.$2.amount;
    _intakeRecipeBox.putAt(intakeObject.$1, intakeObject.$2);
    return _intakeRecipeBox.getAt(intakeObject.$1);
  }

  Future<IntakeRecipeDBO?> getRecipeIntakeById(String intakeId) async {
    return _intakeRecipeBox.values
        .firstWhereOrNull((intake) => intake.id == intakeId);
  }

  Future<List<IntakeRecipeDBO>> getAllRecipeIntakes() async {
    return _intakeRecipeBox.values.toList();
  }

  Future<List<IntakeRecipeDBO>> getAllRecipeIntakesByDate(
      IntakeTypeDBO intakeType, DateTime dateTime) async {
    return _intakeRecipeBox.values
        .where((intake) =>
            DateUtils.isSameDay(dateTime, intake.dateTime) &&
            intake.type == intakeType)
        .toList();
  }

  Future<List<IntakeRecipeDBO>> getRecentlyAddedRecipeIntake(
      {int number = 100}) async {
    final intakeList = _intakeRecipeBox.values.toList();

    //  sort list by date (newest first) and filter unique intake
    intakeList.sort((a, b) => (-1) * a.dateTime.compareTo(b.dateTime));

    final filterCodes = <String>{};
    final uniqueIntake = intakeList
        .where((intake) =>
            filterCodes.add(intake.recipe.code ?? intake.recipe.name ?? ""))
        .toList();

    return uniqueIntake.take(number).toList();
  }
}
