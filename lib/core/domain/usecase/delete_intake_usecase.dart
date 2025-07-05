import 'package:opennutritracker/core/data/repository/intake_repository.dart';
import 'package:opennutritracker/core/data/repository/config_repository.dart';
import 'package:opennutritracker/core/domain/entity/intake_entity.dart';

class DeleteIntakeUsecase {
  final IntakeRepository _intakeRepository;
  final ConfigRepository _configRepository;

  DeleteIntakeUsecase(this._intakeRepository, this._configRepository);

  Future<void> deleteIntake(IntakeEntity intakeEntity) async {
    await _intakeRepository.deleteIntake(intakeEntity);
    await _configRepository.setUserIntakeLastUpdate(DateTime.now());
  }
}
