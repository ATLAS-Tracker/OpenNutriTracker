import 'package:opennutritracker/core/data/repository/user_repository.dart';
import 'package:opennutritracker/core/domain/entity/user_entity.dart';

class GetUserUsecase {
  final UserRepository userRepository;

  GetUserUsecase(this.userRepository);

  Future<UserEntity> getUserData({String? userKey}) async {
    return await userRepository.getUserData(userKey: userKey);
  }

  Future<bool> hasUserData({String? userKey}) async {
    return await userRepository.hasUserData(userKey: userKey);
  }
}
