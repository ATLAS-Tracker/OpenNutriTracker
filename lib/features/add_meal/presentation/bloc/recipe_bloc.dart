import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:opennutritracker/core/domain/entity/intake_entity.dart';
import 'package:opennutritracker/core/domain/usecase/get_config_usecase.dart';
import 'package:opennutritracker/core/domain/usecase/get_intake_usecase.dart';
import 'package:opennutritracker/features/add_meal/domain/entity/meal_entity.dart';

part 'recipe_event.dart';

part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final log = Logger('RecipeBloc');

  final GetIntakeUsecase _getIntakeUsecase;
  final GetConfigUsecase _getConfigUsecase;

  RecipeBloc(this._getIntakeUsecase, this._getConfigUsecase)
      : super(RecipeInitial()) {
    on<LoadRecipeEvent>((event, emit) async {
      emit(RecipeLoadingState());
      try {
        final config = await _getConfigUsecase.getConfig();
        final recentIntake = await _getIntakeUsecase.getRecentIntake();
        final searchString = (event.searchString).toLowerCase();

        if (searchString.isEmpty) {
          emit(RecipeLoadedState(
            recipes: recentIntake
                .where((intake) => intake.meal.mealOrRecipe == "recipe")
                .map((intake) => intake.meal)
                .toList(),
            usesImperialUnits: config.usesImperialUnits,
          ));
        } else {
          emit(RecipeLoadedState(
            recipes: recentIntake
                .where((intake) =>
                    intake.meal.mealOrRecipe == "recipe" &&
                    matchesSearchString(searchString)(intake))
                .map((intake) => intake.meal)
                .toList(),
            usesImperialUnits: config.usesImperialUnits,
          ));
        }
      } catch (error) {
        log.severe(error);
        emit(RecipeFailedState());
      }
    });
  }

  bool Function(IntakeEntity) matchesSearchString(String searchString) {
    return (intake) =>
        (intake.meal.name?.toLowerCase().contains(searchString) ?? false) ||
        (intake.meal.brands?.toLowerCase().contains(searchString) ?? false);
  }
}
