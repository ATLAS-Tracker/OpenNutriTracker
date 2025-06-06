import 'package:opennutritracker/core/data/data_source/intake_data_source.dart';
import 'package:opennutritracker/core/data/dbo/intake_dbo.dart';
import 'package:opennutritracker/core/data/dbo/intake_type_dbo.dart';
import 'package:opennutritracker/core/domain/entity/intake_entity.dart';
import 'package:opennutritracker/core/domain/entity/intake_type_entity.dart';
import 'package:opennutritracker/core/data/sync/intake_sync_listener.dart';

class IntakeRepository {
  final IntakeDataSource _intakeDataSource;
  final IntakeSyncListener? _syncListener;

  IntakeRepository(this._intakeDataSource, [this._syncListener]);

  Future<void> addIntake(IntakeEntity intakeEntity) async {
    final intakeDBO = IntakeDBO.fromIntakeEntity(intakeEntity);

    await _intakeDataSource.addIntake(intakeDBO);
    await _syncListener?.onAdd(intakeDBO);
  }

  Future<void> addAllIntakeDBOs(List<IntakeDBO> intakeDBOs) async {
    await _intakeDataSource.addAllIntakes(intakeDBOs);
  }

  Future<void> deleteIntake(IntakeEntity intakeEntity) async {
    await _intakeDataSource.deleteIntakeFromId(intakeEntity.id);
    await _syncListener?.onDelete(intakeEntity.id);
  }

  Future<IntakeEntity?> updateIntake(
      String intakeId, Map<String, dynamic> fields) async {
    var result = await _intakeDataSource.updateIntake(intakeId, fields);
    if (result != null) {
      await _syncListener?.onUpdate(intakeId, fields);
    }
    return result == null ? null : IntakeEntity.fromIntakeDBO(result);
  }

  Future<List<IntakeDBO>> getAllIntakesDBO() async {
    return await _intakeDataSource.getAllIntakes();
  }

  Future<List<IntakeEntity>> getIntakeByDateAndType(
      IntakeTypeEntity intakeType, DateTime date) async {
    final intakeDBOList = await _intakeDataSource.getAllIntakesByDate(
        IntakeTypeDBO.fromIntakeTypeEntity(intakeType), date);

    return intakeDBOList
        .map((intakeDBO) => IntakeEntity.fromIntakeDBO(intakeDBO))
        .toList();
  }

  Future<List<IntakeEntity>> getRecentIntake() async {
    final intakeList = await _intakeDataSource.getRecentlyAddedIntake();

    return intakeList
        .map((intakeDBO) => IntakeEntity.fromIntakeDBO(intakeDBO))
        .toList();
  }

  Future<IntakeEntity?> getIntakeById(String intakeId) async {
    final result = await _intakeDataSource.getIntakeById(intakeId);
    return result == null ? null : IntakeEntity.fromIntakeDBO(result);
  }

  Future<List<IntakeEntity>> getIntakeRecipe() async {
    final intakeList = await _intakeDataSource.getIntakeRecipe();
    return intakeList
        .map((intakeDBO) => IntakeEntity.fromIntakeDBO(intakeDBO))
        .toList();
  }
}
