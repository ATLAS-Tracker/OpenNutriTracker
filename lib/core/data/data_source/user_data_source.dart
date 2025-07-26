import 'package:opennutritracker/core/utils/hive_db_provider.dart';
import 'package:logging/logging.dart';
import 'package:opennutritracker/core/data/dbo/user_dbo.dart';
import 'package:opennutritracker/core/data/dbo/user_gender_dbo.dart';
import 'package:opennutritracker/core/data/dbo/user_pal_dbo.dart';
import 'package:opennutritracker/core/data/dbo/user_weight_goal_dbo.dart';
import 'package:opennutritracker/core/data/dbo/user_role_dbo.dart';

class UserDataSource {
  static const _userKey = "UserKey";
  final log = Logger('UserDataSource');
  final HiveDBProvider _hive;

  UserDataSource(this._hive);

  Future<void> saveUserData(UserDBO userDBO) async {
    log.fine('Updating user in db');
    await _hive.userBox.put(_userKey, userDBO);
  }

  Future<bool> hasUserData() async => _hive.userBox.containsKey(_userKey);

  // TODO remove dummy data
  Future<UserDBO> getUserData() async {
    return _hive.userBox.get(_userKey) ??
        UserDBO(
            name: 'John Doe',
            birthday: DateTime(2000, 1, 1),
            heightCM: 180,
            weightKG: 80,
            gender: UserGenderDBO.male,
            goal: UserWeightGoalDBO.maintainWeight,
            pal: UserPALDBO.active,
            role: UserRoleDBO.coach, //  TODO
            profileImagePath: null);
  }
}
