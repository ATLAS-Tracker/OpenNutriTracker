import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:opennutritracker/core/domain/entity/intake_entity.dart';
import 'package:opennutritracker/core/domain/usecase/get_config_usecase.dart';
import 'package:opennutritracker/core/domain/usecase/get_intake_usecase.dart';
import 'package:opennutritracker/features/add_meal/domain/entity/meal_entity.dart';

part 'recipe_search_event.dart';

part 'recipe_search_state.dart';

class RecipeSearchBloc extends Bloc<RecipeSearchEvent, RecipeSearchState> {
  final log = Logger('RecipeSearchBloc');

  final GetIntakeUsecase _getIntakeUsecase;
  final GetConfigUsecase _getConfigUsecase;

  RecipeSearchBloc(this._getIntakeUsecase, this._getConfigUsecase)
      : super(RecipeInitial()) {
    on<LoadRecipeSearchEvent>((event, emit) async {
      emit(RecipeLoadingState());
      try {
        final config = await _getConfigUsecase.getConfig();
        final recipeIntake = await _getIntakeUsecase.getIntakeByRecipe();
        final searchString = (event.searchString).toLowerCase();

        if (searchString.isEmpty) {
          emit(RecipeLoadedState(
            recipes: recipeIntake.map((intake) => intake.meal).toList(),
            usesImperialUnits: config.usesImperialUnits,
          ));
        } else {
          emit(RecipeLoadedState(
            recipes: recipeIntake
                .where((intake) => matchesSearchString(searchString)(intake))
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
