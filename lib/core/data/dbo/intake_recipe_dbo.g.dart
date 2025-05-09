// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intake_recipe_dbo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IntakeRecipeDBOAdapter extends TypeAdapter<IntakeRecipeDBO> {
  @override
  final int typeId = 18;

  @override
  IntakeRecipeDBO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IntakeRecipeDBO(
      id: fields[0] as String,
      unit: fields[1] as String,
      amount: fields[2] as double,
      type: fields[3] as IntakeTypeDBO,
      recipe: fields[4] as RecipeDBO,
      dateTime: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, IntakeRecipeDBO obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.unit)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.recipe)
      ..writeByte(5)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IntakeRecipeDBOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IntakeRecipeDBO _$IntakeRecipeDBOFromJson(Map<String, dynamic> json) =>
    IntakeRecipeDBO(
      id: json['id'] as String,
      unit: json['unit'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: $enumDecode(_$IntakeTypeDBOEnumMap, json['type']),
      recipe: RecipeDBO.fromJson(json['recipe'] as Map<String, dynamic>),
      dateTime: DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$IntakeRecipeDBOToJson(IntakeRecipeDBO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'unit': instance.unit,
      'amount': instance.amount,
      'type': _$IntakeTypeDBOEnumMap[instance.type]!,
      'recipe': instance.recipe,
      'dateTime': instance.dateTime.toIso8601String(),
    };

const _$IntakeTypeDBOEnumMap = {
  IntakeTypeDBO.breakfast: 'breakfast',
  IntakeTypeDBO.lunch: 'lunch',
  IntakeTypeDBO.dinner: 'dinner',
  IntakeTypeDBO.snack: 'snack',
};
