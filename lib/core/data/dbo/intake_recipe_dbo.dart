import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:opennutritracker/core/data/dbo/intake_type_dbo.dart';
import 'package:opennutritracker/core/data/dbo/recipe_dbo.dart';
import 'package:opennutritracker/core/domain/entity/intake_recipe_entity.dart';

part 'intake_recipe_dbo.g.dart';

@HiveType(typeId: 18)
@JsonSerializable()
class IntakeRecipeDBO extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String unit;
  @HiveField(2)
  double amount;
  @HiveField(3)
  IntakeTypeDBO type;
  @HiveField(4)
  RecipeDBO recipe;
  @HiveField(5)
  DateTime dateTime;

  IntakeRecipeDBO(
      {required this.id,
      required this.unit,
      required this.amount,
      required this.type,
      required this.recipe,
      required this.dateTime});

  factory IntakeRecipeDBO.fromIntakeEntity(IntakeRecipeEntity entity) {
    return IntakeRecipeDBO(
        id: entity.id,
        unit: entity.unit,
        amount: entity.amount,
        type: IntakeTypeDBO.fromIntakeTypeEntity(entity.type),
        recipe: RecipeDBO.fromReceipe(entity.recipe),
        dateTime: entity.dateTime);
  }

  factory IntakeRecipeDBO.fromJson(Map<String, dynamic> json) =>
      _$IntakeRecipeDBOFromJson(json);

  Map<String, dynamic> toJson() => _$IntakeRecipeDBOToJson(this);
}
