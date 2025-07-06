import 'package:opennutritracker/core/data/repository/intake_repository.dart';
import 'package:opennutritracker/core/data/repository/config_repository.dart';
import 'package:opennutritracker/core/domain/entity/intake_entity.dart';

class AddIntakeUsecase {
  final IntakeRepository _intakeRepository;
  final ConfigRepository _configRepository;

  AddIntakeUsecase(this._intakeRepository, this._configRepository);

  Future<void> addIntake(IntakeEntity intakeEntity) async {
    await _intakeRepository.addIntake(intakeEntity);
    await _configRepository.setUserIntakeLastUpdate(DateTime.now());
  }
}
