// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_nutriments_portion_dbo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealNutrimentsPerPortionDBOAdapter
    extends TypeAdapter<MealNutrimentsPerPortionDBO> {
  @override
  final int typeId = 17;

  @override
  MealNutrimentsPerPortionDBO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealNutrimentsPerPortionDBO(
      energyKcalTotal: fields[0] as double?,
      carbohydratesTotal: fields[1] as double?,
      fatTotal: fields[2] as double?,
      proteinsTotal: fields[3] as double?,
      sugarsTotal: fields[4] as double?,
      saturatedFatTotal: fields[5] as double?,
      fiberTotal: fields[6] as double?,
      numberOfPortions: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MealNutrimentsPerPortionDBO obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.energyKcalTotal)
      ..writeByte(1)
      ..write(obj.carbohydratesTotal)
      ..writeByte(2)
      ..write(obj.fatTotal)
      ..writeByte(3)
      ..write(obj.proteinsTotal)
      ..writeByte(4)
      ..write(obj.sugarsTotal)
      ..writeByte(5)
      ..write(obj.saturatedFatTotal)
      ..writeByte(6)
      ..write(obj.fiberTotal)
      ..writeByte(7)
      ..write(obj.numberOfPortions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealNutrimentsPerPortionDBOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealNutrimentsPerPortionDBO _$MealNutrimentsPerPortionDBOFromJson(
        Map<String, dynamic> json) =>
    MealNutrimentsPerPortionDBO(
      energyKcalTotal: (json['energyKcalTotal'] as num?)?.toDouble(),
      carbohydratesTotal: (json['carbohydratesTotal'] as num?)?.toDouble(),
      fatTotal: (json['fatTotal'] as num?)?.toDouble(),
      proteinsTotal: (json['proteinsTotal'] as num?)?.toDouble(),
      sugarsTotal: (json['sugarsTotal'] as num?)?.toDouble(),
      saturatedFatTotal: (json['saturatedFatTotal'] as num?)?.toDouble(),
      fiberTotal: (json['fiberTotal'] as num?)?.toDouble(),
      numberOfPortions: (json['numberOfPortions'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MealNutrimentsPerPortionDBOToJson(
        MealNutrimentsPerPortionDBO instance) =>
    <String, dynamic>{
      'energyKcalTotal': instance.energyKcalTotal,
      'carbohydratesTotal': instance.carbohydratesTotal,
      'fatTotal': instance.fatTotal,
      'proteinsTotal': instance.proteinsTotal,
      'sugarsTotal': instance.sugarsTotal,
      'saturatedFatTotal': instance.saturatedFatTotal,
      'fiberTotal': instance.fiberTotal,
      'numberOfPortions': instance.numberOfPortions,
    };
