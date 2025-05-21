import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'meal_type_extensions.dart';

part 'meal_type.g.dart';

/// Enum representing the type of a meal entry
/// Can be either a meal or a recipe
@HiveType(typeId: 10)
@JsonEnum()
enum MealType {
  @HiveField(0)
  meal,
  @HiveField(1)
  recipe,
}

/// JSON converter for MealType enum
class MealTypeJsonConverter implements JsonConverter<MealType?, String?> {
  const MealTypeJsonConverter();

  @override
  MealType? fromJson(String? json) {
    if (json == null) return null;
    return json.toMealType();
  }

  @override
  String? toJson(MealType? object) {
    return object?.toShortString();
  }
}

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