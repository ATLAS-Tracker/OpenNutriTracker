import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sync_action.g.dart';

@HiveType(typeId: 18)
@JsonSerializable()
class SyncAction {
  @HiveField(0)
  String action;

  @HiveField(1)
  String table;

  @HiveField(2)
  Map<String, dynamic>? data;

  @HiveField(3)
  String id;

  @HiveField(4)
  int attempts;

  @HiveField(5)
  DateTime timestamp;

  SyncAction({
    required this.action,
    required this.table,
    this.data,
    required this.id,
    this.attempts = 0,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory SyncAction.fromJson(Map<String, dynamic> json) =>
      _$SyncActionFromJson(json);

  Map<String, dynamic> toJson() => _$SyncActionToJson(this);
}
