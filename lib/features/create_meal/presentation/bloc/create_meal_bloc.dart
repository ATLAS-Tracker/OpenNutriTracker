import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opennutritracker/core/domain/entity/intake_entity.dart';
import 'package:opennutritracker/features/add_meal/domain/entity/meal_entity.dart';
import 'package:opennutritracker/core/domain/entity/intake_type_entity.dart';
import 'package:opennutritracker/core/utils/id_generator.dart';
import 'package:opennutritracker/core/domain/usecase/add_tracked_day_usecase.dart';
import 'package:opennutritracker/core/domain/usecase/add_recipe_intake_usecase.dart';
import 'package:opennutritracker/core/domain/usecase/get_kcal_goal_usecase.dart';
import 'package:opennutritracker/core/domain/usecase/get_macro_goal_usecase.dart';
import 'package:opennutritracker/core/domain/entity/intake_recipe_entity.dart';
import 'package:opennutritracker/features/create_meal/domain/entity/recipe.dart';
import 'package:logging/logging.dart';
part 'create_meal_event.dart';
part 'create_meal_state.dart';

class CreateMealBloc extends Bloc<CreateMealEvent, CreateMealState> {
  List<IntakeEntity> _intakeList = [];
  final AddIntakeRecipeUsecase _addRecipeIntakeUseCase;
  final AddTrackedDayUsecase _addTrackedDayUsecase;
  final GetKcalGoalUsecase _getKcalGoalUsecase;
  final GetMacroGoalUsecase _getMacroGoalUsecase;
  final _log = Logger('ConfigDataSource');

  CreateMealBloc(this._addRecipeIntakeUseCase, this._addTrackedDayUsecase,
      this._getKcalGoalUsecase, this._getMacroGoalUsecase)
      : super(const CreateMealState()) {
    on<InitializeCreateMealEvent>((event, emit) async {
      emit(state.copyWith(isOnCreateMealScreen: true));
    });
    on<ExitCreateMealScreenEvent>((event, emit) async {
      emit(state.copyWith(isOnCreateMealScreen: false));
    });
  }

  void clearIntakeList() {
    _intakeList.clear();
    _emitUpdatedState();
  }

  void addIntake(String unit, String amountText, IntakeTypeEntity type,
      MealEntity meal, DateTime day) {
    final quantity = double.tryParse(amountText.replaceAll(',', '.'));
    if (quantity == null) return;

    final intakeEntity = IntakeEntity(
      id: IdGenerator.getUniqueID(),
      unit: unit,
      amount: quantity,
      type: type,
      meal: meal,
      dateTime: day,
    );

    _intakeList.add(intakeEntity);
    _emitUpdatedState();
  }

  void removeIntake(String intakeId) {
    _intakeList.removeWhere((intake) => intake.id == intakeId);
    _emitUpdatedState();
  }

  void updateIntakeAmount(String intakeId, double newAmount) {
    final index = _intakeList.indexWhere((intake) => intake.id == intakeId);
    if (index != -1) {
      _intakeList[index] = _intakeList[index].copyWith(amount: newAmount);
      _emitUpdatedState();
    }
  }

  void _emitUpdatedState() {
    final totals = computeMacros();
    emit(state.copyWith(
      intakeList: List.from(_intakeList),
      totalProteins: totals['totalProteins']!,
      totalCarbs: totals['totalCarbs']!,
      totalFats: totals['totalFats']!,
    ));
  }

  Map<String, double> computeMacros() {
    double totalProteins = 0;
    double totalCarbs = 0;
    double totalFats = 0;
    double totalKcal = 0;

    for (final intake in _intakeList) {
      final nutriments = intake.meal.nutriments;
      final amount = intake.amount;

      // We don't divide by 100 here because later we will divide by 100 (we work with portions so later we don't have to divide by 100)
      // TODO: find a better way to do this
      totalProteins += (nutriments.proteins100 ?? 0) * amount / 100;
      totalCarbs += (nutriments.carbohydrates100 ?? 0) * amount / 100;
      totalFats += (nutriments.fat100 ?? 0) * amount / 100;
      totalKcal += (nutriments.energyKcal100 ?? 0) * amount / 100;
    }

    return {
      'totalProteins': totalProteins,
      'totalCarbs': totalCarbs,
      'totalFats': totalFats,
      'totalKcal': totalKcal,
    };
  }

  void addRecipeIntake(String unit, String amountText, IntakeTypeEntity type,
      Recipe recipe, DateTime day) async {
    final quantity = double.parse(amountText.replaceAll(',', '.'));

    final intakeRecipeEntity = IntakeRecipeEntity(
        id: IdGenerator.getUniqueID(),
        unit: unit,
        amount: quantity,
        type: type,
        recipe: recipe,
        dateTime: day);

    await _addRecipeIntakeUseCase.addIntake(intakeRecipeEntity);
    _updateTrackedDay(intakeRecipeEntity, day);
  }

  Future<void> _updateTrackedDay(
      IntakeRecipeEntity intakeRecipeEntity, DateTime day) async {
    final hasTrackedDay = await _addTrackedDayUsecase.hasTrackedDay(day);
    if (!hasTrackedDay) {
      final totalKcalGoal = await _getKcalGoalUsecase.getKcalGoal();
      final totalCarbsGoal =
          await _getMacroGoalUsecase.getCarbsGoal(totalKcalGoal);
      final totalFatGoal =
          await _getMacroGoalUsecase.getFatsGoal(totalKcalGoal);
      final totalProteinGoal =
          await _getMacroGoalUsecase.getProteinsGoal(totalKcalGoal);

      await _addTrackedDayUsecase.addNewTrackedDay(
          day, totalKcalGoal, totalCarbsGoal, totalFatGoal, totalProteinGoal);
    }

    // Log the tracked values before saving
    _log.fine('Adding tracked day data: '
        'date=$day, '
        'kcal=${intakeRecipeEntity.totalKcal}, '
        'carbs=${intakeRecipeEntity.totalCarbsGram}, '
        'fats=${intakeRecipeEntity.totalFatsGram}, '
        'proteins=${intakeRecipeEntity.totalProteinsGram}');

    _addTrackedDayUsecase.addDayCaloriesTracked(
        day, intakeRecipeEntity.totalKcal);
    _addTrackedDayUsecase.addDayMacrosTracked(day,
        carbsTracked: intakeRecipeEntity.totalCarbsGram,
        fatTracked: intakeRecipeEntity.totalFatsGram,
        proteinTracked: intakeRecipeEntity.totalProteinsGram);
  }
}
