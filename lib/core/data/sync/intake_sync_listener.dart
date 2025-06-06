import 'dart:convert';
import 'package:logging/logging.dart';
import 'package:opennutritracker/core/data/dbo/intake_dbo.dart';
import 'package:opennutritracker/core/data/dbo/sql_command_dbo.dart';
import 'package:opennutritracker/core/data/repository/sql_queue_repository.dart';

class IntakeSyncListener {
  final SqlQueueRepository _repository;
  final log = Logger('IntakeSyncListener');

  IntakeSyncListener(this._repository);

  Future<void> onAdd(IntakeDBO intake) async {
    final mealJson = jsonEncode(intake.meal.toJson());
    final sql =
        "INSERT INTO intakes (id, unit, amount, type, meal, dateTime) VALUES ('${intake.id}', '${intake.unit}', ${intake.amount}, '${intake.type.name}', '$mealJson', '${intake.dateTime.toIso8601String()}')";
    await _repository.enqueue(
        SqlCommandDBO(id: intake.id, command: sql));
  }

  Future<void> onUpdate(String id, Map<String, dynamic> fields) async {
    final assignments = fields.entries
        .map((e) => "${e.key} = '${e.value}'")
        .join(', ');
    final sql = "UPDATE intakes SET $assignments WHERE id = '$id'";
    await _repository.enqueue(SqlCommandDBO(id: id, command: sql));
  }

  Future<void> onDelete(String id) async {
    final sql = "DELETE FROM intakes WHERE id = '$id'";
    await _repository.enqueue(SqlCommandDBO(id: id, command: sql));
  }
}
