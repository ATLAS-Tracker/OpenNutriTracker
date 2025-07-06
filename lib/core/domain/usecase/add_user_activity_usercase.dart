import 'package:opennutritracker/core/data/repository/user_activity_repository.dart';
import 'package:opennutritracker/core/data/repository/config_repository.dart';
import 'package:opennutritracker/core/domain/entity/user_activity_entity.dart';

class AddUserActivityUsecase {
  final UserActivityRepository _userActivityRepository;
  final ConfigRepository _configRepository;

  AddUserActivityUsecase(this._userActivityRepository, this._configRepository);

  Future<void> addUserActivity(UserActivityEntity userActivityEntity) async {
    await _userActivityRepository.addUserActivity(userActivityEntity);
    await _configRepository.setUserActivityLastUpdate(DateTime.now());
  }
}
