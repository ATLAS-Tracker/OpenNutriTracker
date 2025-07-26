// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'macro_goal_dbo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MacroGoalDboAdapter extends TypeAdapter<MacroGoalDbo> {
  @override
  final int typeId = 20;

  @override
  MacroGoalDbo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MacroGoalDbo(
      fields[0] as String,
      fields[1] as DateTime,
      fields[2] as DateTime,
      fields[3] as double,
      fields[4] as double,
      fields[5] as double,
      fields[6] as double,
      fields[7] as double,
      fields[8] as double,
      fields[9] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MacroGoalDbo obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.oldCarbsGoal)
      ..writeByte(5)
      ..write(obj.oldFatsGoal)
      ..writeByte(6)
      ..write(obj.oldProteinsGoal)
      ..writeByte(7)
      ..write(obj.newCarbsGoal)
      ..writeByte(8)
      ..write(obj.newFatsGoal)
      ..writeByte(9)
      ..write(obj.newProteinsGoal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MacroGoalDboAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MacroGoalDbo _$MacroGoalDboFromJson(Map<String, dynamic> json) => MacroGoalDbo(
      json['id'] as String,
      DateTime.parse(json['date'] as String),
      DateTime.parse(json['updatedAt'] as String),
      (json['weight'] as num).toDouble(),
      (json['oldCarbsGoal'] as num).toDouble(),
      (json['oldFatsGoal'] as num).toDouble(),
      (json['oldProteinsGoal'] as num).toDouble(),
      (json['newCarbsGoal'] as num).toDouble(),
      (json['newFatsGoal'] as num).toDouble(),
      (json['newProteinsGoal'] as num).toDouble(),
    );

Map<String, dynamic> _$MacroGoalDboToJson(MacroGoalDbo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'weight': instance.weight,
      'oldCarbsGoal': instance.oldCarbsGoal,
      'oldFatsGoal': instance.oldFatsGoal,
      'oldProteinsGoal': instance.oldProteinsGoal,
      'newCarbsGoal': instance.newCarbsGoal,
      'newFatsGoal': instance.newFatsGoal,
      'newProteinsGoal': instance.newProteinsGoal,
    };
