// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_dbo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeDBOAdapter extends TypeAdapter<RecipeDBO> {
  @override
  final int typeId = 16;

  @override
  RecipeDBO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeDBO(
      code: fields[0] as String?,
      name: fields[1] as String?,
      nutriments: fields[2] as MealNutrimentsPerPortionDBO,
    );
  }

  @override
  void write(BinaryWriter writer, RecipeDBO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.nutriments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeDBOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeDBO _$RecipeDBOFromJson(Map<String, dynamic> json) => RecipeDBO(
      code: json['code'] as String?,
      name: json['name'] as String?,
      nutriments: MealNutrimentsPerPortionDBO.fromJson(
          json['nutriments'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecipeDBOToJson(RecipeDBO instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'nutriments': instance.nutriments,
    };
