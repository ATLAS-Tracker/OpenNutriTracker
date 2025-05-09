import 'package:opennutritracker/core/data/repository/intake_recipe_repository.dart';
import 'package:opennutritracker/core/domain/entity/intake_recipe_entity.dart';

class AddIntakeRecipeUsecase {
  final IntakeRecipeRepository _intakeRecipeRepository;

  AddIntakeRecipeUsecase(this._intakeRecipeRepository);

  Future<void> addIntake(IntakeRecipeEntity intakeRecipeEntity) async {
    return await _intakeRecipeRepository.addIntake(intakeRecipeEntity);
  }
}
