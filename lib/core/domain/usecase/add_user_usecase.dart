import 'package:opennutritracker/core/data/repository/user_repository.dart';
import 'package:opennutritracker/core/domain/entity/user_entity.dart';

class AddUserUsecase {
  final UserRepository _userRepository;

  AddUserUsecase(this._userRepository);

  Future<void> addUser(UserEntity userEntity, {String? userKey}) async {
    return await _userRepository.updateUserData(userEntity, userKey: userKey);
  }
}
