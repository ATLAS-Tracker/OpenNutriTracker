import 'package:opennutritracker/core/data/repository/config_repository.dart';

class GetMacroGoalUsecase {
  final ConfigRepository _configRepository;

  GetMacroGoalUsecase(this._configRepository);

  static const _defaultCarbsGoal = 250.0;
  static const _defaultFatsGoal = 60.0;
  static const _defaultProteinsGoal = 120.0;

  Future<double> getCarbsGoal([double? _]) async {
    final config = await _configRepository.getConfig();
    return config.userCarbGoal ?? _defaultCarbsGoal;
  }

  Future<double> getFatsGoal([double? _]) async {
    final config = await _configRepository.getConfig();
    return config.userFatGoal ?? _defaultFatsGoal;
  }

  Future<double> getProteinsGoal([double? _]) async {
    final config = await _configRepository.getConfig();
    return config.userProteinGoal ?? _defaultProteinsGoal;
  }
}
