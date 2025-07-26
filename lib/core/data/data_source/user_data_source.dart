import 'package:opennutritracker/core/utils/hive_db_provider.dart';
import 'package:logging/logging.dart';
import 'package:opennutritracker/core/data/dbo/user_dbo.dart';

class UserDataSource {
  static const _userKey = "UserKey";
  final log = Logger('UserDataSource');
  final HiveDBProvider _hive;

  UserDataSource(this._hive);

  Future<void> saveUserData(UserDBO userDBO, {String? userKey}) async {
    log.fine('Updating user in db');
    await _hive.userBox.put(userKey ?? _userKey, userDBO);
  }

  Future<bool> hasUserData({String? userKey}) async =>
      _hive.userBox.containsKey(userKey ?? _userKey);

  Future<UserDBO?> getUserData({String? userKey}) async {
    return _hive.userBox.get(userKey ?? _userKey);
  }
}
