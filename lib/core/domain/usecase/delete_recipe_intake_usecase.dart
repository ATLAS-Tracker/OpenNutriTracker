import 'package:opennutritracker/core/data/repository/intake_recipe_repository.dart';
import 'package:opennutritracker/core/domain/entity/intake_recipe_entity.dart';

class DeleteRecipeIntakeUsecase {
  final IntakeRecipeRepository _intakeRecipeRepository;

  DeleteRecipeIntakeUsecase(this._intakeRecipeRepository);

  Future<void> deleteIntake(IntakeRecipeEntity intakeEntity) async {
    await _intakeRecipeRepository.deleteIntake(intakeEntity);
  }
}
