import 'package:opennutritracker/core/data/repository/user_weight_repository.dart';
import 'package:opennutritracker/core/domain/entity/user_weight_entity.dart';
import 'package:opennutritracker/core/domain/usecase/get_user_usecase.dart';
import 'package:opennutritracker/core/utils/locator.dart';

class GetWeightUsecase {
  final UserWeightRepository _userWeightRepository;
  final GetUserUsecase _getUserUsecase = locator<GetUserUsecase>();

  // Constructor updated to accept GetUserUsecase
  GetWeightUsecase(this._userWeightRepository);

  Future<UserWeightEntity?> getUserWeightByDate(DateTime dateTime) async {
    return await _userWeightRepository.getUserWeightByDate(dateTime);
  }

  Future<UserWeightEntity?> getTodayUserWeight() async {
    return await _userWeightRepository.getUserWeightByDate(DateTime.now());
  }

  /// Fetches the last recorded weight for the user.
  ///
  /// If no weight entries are found in the repository, this function
  /// falls back to returning the user's default weight as specified
  /// in their profile (userData.weightKG).
  ///
  /// Returns a [Future<double>] representing the user's last known weight
  /// or their default weight if no entries exist.
  Future<double> getLastUserWeight() async {
    final UserWeightEntity? lastUserWeight =
        await _userWeightRepository.getLastUserWeight();

    if (lastUserWeight != null) {
      return lastUserWeight.weight;
    }

    // If no last weight is found, fetch the user's default weight from their profile.
    final userData = await _getUserUsecase.getUserData();
    return userData.weightKG;
  }
}
