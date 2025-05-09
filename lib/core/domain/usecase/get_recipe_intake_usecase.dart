import 'package:opennutritracker/core/data/repository/intake_recipe_repository.dart';
import 'package:opennutritracker/core/domain/entity/intake_recipe_entity.dart';
import 'package:opennutritracker/core/domain/entity/intake_type_entity.dart';

class GetIntakeRecipeUsecase {
  final IntakeRecipeRepository _intakeRecipeRepository;

  GetIntakeRecipeUsecase(this._intakeRecipeRepository);

  Future<List<IntakeRecipeEntity>> _getIntakeRecipeByDay(
      IntakeTypeEntity type, DateTime day) async {
    return await _intakeRecipeRepository.getIntakeByDateAndType(type, day);
  }

  Future<List<IntakeRecipeEntity>> getBreakfastIntakeByDay(day) async =>
      await _getIntakeRecipeByDay(IntakeTypeEntity.breakfast, day);

  Future<List<IntakeRecipeEntity>> getTodayBreakfastIntake() async =>
      getBreakfastIntakeByDay(DateTime.now());

  Future<List<IntakeRecipeEntity>> getLunchIntakeByDay(day) async =>
      await _getIntakeRecipeByDay(IntakeTypeEntity.lunch, day);

  Future<List<IntakeRecipeEntity>> getTodayLunchIntake() async =>
      await getLunchIntakeByDay(DateTime.now());

  Future<List<IntakeRecipeEntity>> getDinnerIntakeByDay(day) async =>
      await _getIntakeRecipeByDay(IntakeTypeEntity.dinner, day);

  Future<List<IntakeRecipeEntity>> getTodayDinnerIntake() async =>
      await getDinnerIntakeByDay(DateTime.now());

  Future<List<IntakeRecipeEntity>> getSnackIntakeByDay(day) async =>
      await _getIntakeRecipeByDay(IntakeTypeEntity.snack, day);

  Future<List<IntakeRecipeEntity>> getTodaySnackIntake() async =>
      await getSnackIntakeByDay(DateTime.now());

  Future<List<IntakeRecipeEntity>> getRecentRecipeIntake() async {
    return _intakeRecipeRepository.getRecentIntake();
  }

  Future<IntakeRecipeEntity?> getRecipeIntakeById(String intakeId) async {
    return _intakeRecipeRepository.getIntakeById(intakeId);
  }
}
