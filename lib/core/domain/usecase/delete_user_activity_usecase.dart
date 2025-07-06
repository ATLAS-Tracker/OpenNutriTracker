import 'package:opennutritracker/core/data/repository/user_activity_repository.dart';
import 'package:opennutritracker/core/data/repository/config_repository.dart';
import 'package:opennutritracker/core/domain/entity/user_activity_entity.dart';

class DeleteUserActivityUsecase {
  final UserActivityRepository _userActivityRepository;
  final ConfigRepository _configRepository;

  DeleteUserActivityUsecase(this._userActivityRepository, this._configRepository);

  Future<void> deleteUserActivity(UserActivityEntity activityEntity) async {
    await _userActivityRepository.deleteUserActivity(activityEntity);
    await _configRepository.setUserActivityLastUpdate(DateTime.now());
  }
}
