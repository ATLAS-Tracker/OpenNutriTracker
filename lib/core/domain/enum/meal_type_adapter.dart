import 'package:hive_flutter/hive_flutter.dart';
import 'package:opennutritracker/core/domain/enum/meal_type.dart';

/// TypeAdapter for MealType enum to be used with Hive
class MealTypeAdapter extends TypeAdapter<MealType> {
  @override
  final int typeId = 10;

  @override
  MealType read(BinaryReader reader) {
    final index = reader.readByte();
    return MealType.values[index];
  }

  @override
  void write(BinaryWriter writer, MealType obj) {
    writer.writeByte(obj.index);
  }
}