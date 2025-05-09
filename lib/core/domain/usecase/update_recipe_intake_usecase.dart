import 'package:opennutritracker/core/data/repository/intake_recipe_repository.dart';
import 'package:opennutritracker/core/domain/entity/intake_recipe_entity.dart';

class UpdateRecipeIntakeUsecase {
  final IntakeRecipeRepository _intakeRecipeRepository;

  UpdateRecipeIntakeUsecase(this._intakeRecipeRepository);

  Future<IntakeRecipeEntity?> updateIntake(
      String intakeId, Map<String, dynamic> intakeFields) async {
    return await _intakeRecipeRepository.updateIntake(intakeId, intakeFields);
  }
}
