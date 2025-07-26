import 'package:opennutritracker/core/data/repository/macro_goal_repository.dart';
import 'package:opennutritracker/core/domain/entity/macro_goal_entity.dart';
import 'package:opennutritracker/core/utils/locator.dart';

class GetMacroGoalUsecase {
  final MacroGoalRepository _macroGoalRepository =
      locator<MacroGoalRepository>();

  GetMacroGoalUsecase();

  Future<double?> getCarbsGoal() async {
    final MacroGoalEntity? macroGoal =
        await _macroGoalRepository.getMacroGoal();
    return macroGoal?.newCarbsGoal;
  }

  Future<double?> getFatsGoal() async {
    final MacroGoalEntity? macroGoal =
        await _macroGoalRepository.getMacroGoal();
    return macroGoal?.newFatsGoal;
  }

  Future<double?> getProteinsGoal() async {
    final MacroGoalEntity? macroGoal =
        await _macroGoalRepository.getMacroGoal();
    return macroGoal?.newProteinsGoal;
  }

  /// Optionnel : récupérer l'entité complète
  Future<MacroGoalEntity?> getMacroGoal() async {
    return await _macroGoalRepository.getMacroGoal();
  }
}
