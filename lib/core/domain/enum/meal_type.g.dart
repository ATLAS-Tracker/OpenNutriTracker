// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealTypeAdapter extends TypeAdapter<MealType> {
  @override
  final int typeId = 10;

  @override
  MealType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MealType.meal;
      case 1:
        return MealType.recipe;
      default:
        return MealType.meal;
    }
  }

  @override
  void write(BinaryWriter writer, MealType obj) {
    switch (obj) {
      case MealType.meal:
        writer.writeByte(0);
        break;
      case MealType.recipe:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}