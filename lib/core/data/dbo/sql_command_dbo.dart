import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sql_command_dbo.g.dart';

@HiveType(typeId: 18)
@JsonSerializable()
class SqlCommandDBO extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String command;

  @HiveField(2)
  int retryCount;

  SqlCommandDBO({required this.id, required this.command, this.retryCount = 0});

  factory SqlCommandDBO.fromJson(Map<String, dynamic> json) =>
      _$SqlCommandDBOFromJson(json);

  Map<String, dynamic> toJson() => _$SqlCommandDBOToJson(this);
}
