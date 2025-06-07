// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_action.dart';

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
      data: (fields[2] as Map).cast<String, dynamic>(),
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
