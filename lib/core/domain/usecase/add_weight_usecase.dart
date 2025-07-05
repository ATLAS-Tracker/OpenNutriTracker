import 'package:opennutritracker/core/data/repository/user_weight_repository.dart';
import 'package:opennutritracker/core/data/repository/config_repository.dart';
import 'package:opennutritracker/core/domain/entity/user_weight_entity.dart';

class AddWeightUsecase {
  final UserWeightRepository _userWeightRepository;
  final ConfigRepository _configRepository;

  AddWeightUsecase(this._userWeightRepository, this._configRepository);

  Future<void> addUserWeight(UserWeightEntity userWeightEntity) async {
    await _userWeightRepository.addUserWeight(userWeightEntity);
    await _configRepository.setUserWeightLastUpdate(DateTime.now());
  }
}
