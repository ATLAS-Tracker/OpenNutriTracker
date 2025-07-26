import 'package:opennutritracker/core/data/data_source/user_data_source.dart';
import 'package:opennutritracker/core/data/dbo/user_dbo.dart';
import 'package:opennutritracker/core/domain/entity/user_entity.dart';

class UserRepository {
  final UserDataSource _userDataSource;

  UserRepository(this._userDataSource);

  Future<void> updateUserData(UserEntity userEntity, {String? userKey}) async {
    final userDBO = UserDBO.fromUserEntity(userEntity);
    await _userDataSource.saveUserData(userDBO, userKey: userKey);
  }

  Future<bool> hasUserData({String? userKey}) async =>
      await _userDataSource.hasUserData(userKey: userKey);

  Future<UserEntity> getUserData({String? userKey}) async {
    final userDBO = await _userDataSource.getUserData(userKey: userKey);
    return UserEntity.fromUserDBO(userDBO);
  }

  Future<UserDBO> getUserDBO({String? userKey}) async {
    final userDBO = await _userDataSource.getUserData(userKey: userKey);
    return userDBO;
  }
}
