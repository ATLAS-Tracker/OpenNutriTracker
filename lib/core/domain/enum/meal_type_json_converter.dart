import 'package:json_annotation/json_annotation.dart';
import 'package:opennutritracker/core/domain/enum/meal_type.dart';

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