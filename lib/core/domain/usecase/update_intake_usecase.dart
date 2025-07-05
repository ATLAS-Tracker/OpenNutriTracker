import 'package:opennutritracker/core/data/repository/intake_repository.dart';
import 'package:opennutritracker/core/data/repository/config_repository.dart';
import 'package:opennutritracker/core/domain/entity/intake_entity.dart';

class UpdateIntakeUsecase {
  final IntakeRepository _intakeRepository;
  final ConfigRepository _configRepository;

  UpdateIntakeUsecase(this._intakeRepository, this._configRepository);

  Future<IntakeEntity?> updateIntake(
      String intakeId, Map<String, dynamic> intakeFields) async {
    final result = await _intakeRepository.updateIntake(intakeId, intakeFields);
    await _configRepository.setUserIntakeLastUpdate(DateTime.now());
    return result;
  }
}
