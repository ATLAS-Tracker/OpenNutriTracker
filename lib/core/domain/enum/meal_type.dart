import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_type.g.dart';

/// Enum representing the type of a meal entry
/// Can be either a meal or a recipe
@HiveType(typeId: 10)
enum MealType {
  @HiveField(0)
  meal,
  @HiveField(1)
  recipe,
}

/// Extension methods for MealType enum
extension MealTypeExtension on MealType {
  /// Convert MealType enum to String
  String toShortString() {
    return toString().split('.').last;
  }
  
  /// Check if this is a recipe type
  bool get isRecipe => this == MealType.recipe;
  
  /// Check if this is a meal type
  bool get isMeal => this == MealType.meal;
}

/// Extension methods for String to convert to MealType
extension StringToMealTypeExtension on String {
  /// Convert String to MealType
  MealType toMealType() {
    switch (toLowerCase()) {
      case 'recipe':
        return MealType.recipe;
      case 'meal':
      default:
        return MealType.meal;
    }
  }
}

/// Extension methods for nullable MealType
extension NullableMealTypeExtension on MealType? {
  /// Convert nullable MealType to String
  String? toShortString() {
    return this?.toShortString();
  }
  
  /// Check if this is a recipe type
  bool get isRecipe => this == MealType.recipe;
  
  /// Check if this is a meal type
  bool get isMeal => this == MealType.meal;
}