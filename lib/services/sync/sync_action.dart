import 'package:hive_flutter/hive_flutter.dart';

part 'sync_action.g.dart';

@HiveType(typeId: 18)
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

  factory SyncAction.fromJson(Map<String, dynamic> json) => SyncAction(
        action: json['action'] as String,
        table: json['table'] as String,
        data: json['data'] != null
            ? Map<String, dynamic>.from(json['data'] as Map)
            : null,
        id: json['id'] as String,
        attempts: json['attempts'] as int? ?? 0,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );

  Map<String, dynamic> toJson() => {
        'action': action,
        'table': table,
        'data': data,
        'id': id,
        'attempts': attempts,
        'timestamp': timestamp.toIso8601String(),
      };
}
