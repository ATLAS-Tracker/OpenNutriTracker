// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sql_command_dbo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SqlCommandDBOAdapter extends TypeAdapter<SqlCommandDBO> {
  @override
  final int typeId = 18;

  @override
  SqlCommandDBO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SqlCommandDBO(
      id: fields[0] as String,
      command: fields[1] as String,
      retryCount: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SqlCommandDBO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.command)
      ..writeByte(2)
      ..write(obj.retryCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SqlCommandDBOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SqlCommandDBO _$SqlCommandDBOFromJson(Map<String, dynamic> json) =>
    SqlCommandDBO(
      id: json['id'] as String,
      command: json['command'] as String,
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SqlCommandDBOToJson(SqlCommandDBO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'command': instance.command,
      'retryCount': instance.retryCount,
    };
