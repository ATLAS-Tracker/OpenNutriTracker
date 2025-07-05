import 'package:opennutritracker/core/data/repository/user_weight_repository.dart';
import 'package:opennutritracker/core/data/repository/config_repository.dart';

class DeleteUserWeightUsecase {
  final UserWeightRepository _userWeightRepository;
  final ConfigRepository _configRepository;

  DeleteUserWeightUsecase(this._userWeightRepository, this._configRepository);

  Future<void> deleteTodayUserWeight() async {
    await _userWeightRepository.deleteUserWeightByDate(DateTime.now());
    await _configRepository.setUserWeightLastUpdate(DateTime.now());
  }
}
