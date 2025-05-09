import 'package:opennutritracker/core/data/data_source/intake_recipe_data_source.dart';
import 'package:opennutritracker/core/data/dbo/intake_recipe_dbo.dart';
import 'package:opennutritracker/core/data/dbo/intake_type_dbo.dart';
import 'package:opennutritracker/core/domain/entity/intake_recipe_entity.dart';
import 'package:opennutritracker/core/domain/entity/intake_type_entity.dart';

class IntakeRecipeRepository {
  final IntakeRecipeDataSource _intakeRecipeDataSource;

  IntakeRecipeRepository(this._intakeRecipeDataSource);

  Future<void> addIntake(IntakeRecipeEntity intakeEntity) async {
    final intakeDBO = IntakeRecipeDBO.fromIntakeEntity(intakeEntity);

    await _intakeRecipeDataSource.addRecipeIntake(intakeDBO);
  }

  Future<void> addAllIntakeDBOs(List<IntakeRecipeDBO> intakeDBOs) async {
    await _intakeRecipeDataSource.addAllRecipeIntakes(intakeDBOs);
  }

  Future<void> deleteIntake(IntakeRecipeEntity intakeEntity) async {
    await _intakeRecipeDataSource.deleteRecipeIntakeFromId(intakeEntity.id);
  }

  Future<IntakeRecipeEntity?> updateIntake(
      String intakeId, Map<String, dynamic> fields) async {
    var result =
        await _intakeRecipeDataSource.updateRecipeIntake(intakeId, fields);
    return result == null ? null : IntakeRecipeEntity.fromIntakeDBO(result);
  }

  Future<List<IntakeRecipeDBO>> getAllIntakesDBO() async {
    return await _intakeRecipeDataSource.getAllRecipeIntakes();
  }

  Future<List<IntakeRecipeEntity>> getIntakeByDateAndType(
      IntakeTypeEntity intakeType, DateTime date) async {
    final intakeDBOList =
        await _intakeRecipeDataSource.getAllRecipeIntakesByDate(
            IntakeTypeDBO.fromIntakeTypeEntity(intakeType), date);

    return intakeDBOList
        .map((intakeDBO) => IntakeRecipeEntity.fromIntakeDBO(intakeDBO))
        .toList();
  }

  Future<List<IntakeRecipeEntity>> getRecentIntake() async {
    final intakeList =
        await _intakeRecipeDataSource.getRecentlyAddedRecipeIntake();

    return intakeList
        .map((intakeDBO) => IntakeRecipeEntity.fromIntakeDBO(intakeDBO))
        .toList();
  }

  Future<IntakeRecipeEntity?> getIntakeById(String intakeId) async {
    final result = await _intakeRecipeDataSource.getRecipeIntakeById(intakeId);
    return result == null ? null : IntakeRecipeEntity.fromIntakeDBO(result);
  }
}
