// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_action.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SyncActionAdapter extends TypeAdapter<SyncAction> {
  @override
  final int typeId = 18;

  @override
  SyncAction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SyncAction(
      action: fields[0] as String,
      table: fields[1] as String,
      data: (fields[2] as Map?)?.cast<String, dynamic>(),
      id: fields[3] as String,
      attempts: fields[4] as int,
      timestamp: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SyncAction obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.action)
      ..writeByte(1)
      ..write(obj.table)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.attempts)
      ..writeByte(5)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SyncActionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyncAction _$SyncActionFromJson(Map<String, dynamic> json) => SyncAction(
      action: json['action'] as String,
      table: json['table'] as String,
      data: json['data'] as Map<String, dynamic>?,
      id: json['id'] as String,
      attempts: (json['attempts'] as num?)?.toInt() ?? 0,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$SyncActionToJson(SyncAction instance) =>
    <String, dynamic>{
      'action': instance.action,
      'table': instance.table,
      'data': instance.data,
      'id': instance.id,
      'attempts': instance.attempts,
      'timestamp': instance.timestamp.toIso8601String(),
    };
