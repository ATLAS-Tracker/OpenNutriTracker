import 'package:opennutritracker/core/data/repository/macro_goal_repository.dart';
import 'package:opennutritracker/core/domain/entity/macro_goal_entity.dart';
import 'package:opennutritracker/core/utils/locator.dart';

class AddMacroGoalUsecase {
  final MacroGoalRepository _macroGoalRepository =
      locator<MacroGoalRepository>();

  Future<void> addMacroGoal(MacroGoalEntity macroGoal) async {
    await _macroGoalRepository.saveMacroGoal(macroGoal);
  }
}
