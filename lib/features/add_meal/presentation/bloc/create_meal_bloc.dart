import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opennutritracker/core/domain/entity/intake_entity.dart';
import 'package:opennutritracker/core/domain/entity/intake_type_entity.dart';
import 'package:opennutritracker/core/utils/id_generator.dart';
import 'package:opennutritracker/features/add_meal/domain/entity/meal_entity.dart';
import 'package:opennutritracker/features/add_meal/domain/entity/meal_nutriments_entity.dart';
import 'package:opennutritracker/features/add_meal/domain/usecase/get_recipe_usecase.dart';

part 'create_meal_event.dart';
part 'create_meal_state.dart';

class CreateMealBloc extends Bloc<CreateMealEvent, CreateMealState> {
  final GetRecipeUsecase _getRecipeUsecase;

  CreateMealBloc(this._getRecipeUsecase) : super(CreateMealInitial()) {
    on<InitializeCreateMealEvent>((event, emit) {
      emit(CreateMealLoaded(
        intakes: const [],
        totalKcal: 0,
        totalCarbs: 0,
        totalFat: 0,
        totalProtein: 0,
      ));
    });

    on<AddIntakeEvent>((event, emit) async {
      if (state is CreateMealLoaded) {
        final currentState = state as CreateMealLoaded;
        final List<IntakeEntity> updatedIntakes = List.from(currentState.intakes);
        
        // Create a new intake
        final newIntake = IntakeEntity(
          id: IdGenerator.getUniqueID(),
          unit: event.unit,
          amount: event.amount,
          type: event.mealType,
          meal: event.meal,
          dateTime: DateTime.now(),
        );
        
        // If it's a recipe, get the ingredients and add them instead
        if (event.meal.source == MealSourceEntity.recipe) {
          final recipe = await _getRecipeUsecase.getRecipeById(event.meal.code!);
          
          if (recipe != null && recipe.ingredients != null) {
            // Add all ingredients from the recipe
            for (final ingredient in recipe.ingredients!) {
              final ingredientIntake = IntakeEntity(
                id: IdGenerator.getUniqueID(),
                unit: ingredient.mealUnit ?? 'g',
                amount: (ingredient.mealQuantity != null) 
                    ? double.tryParse(ingredient.mealQuantity!) ?? 0 
                    : 0,
                type: event.mealType,
                meal: ingredient,
                dateTime: DateTime.now(),
              );
              updatedIntakes.add(ingredientIntake);
            }
          }
        } else {
          // Add the single intake
          updatedIntakes.add(newIntake);
        }
        
        // Calculate new totals
        final newTotals = _calculateTotals(updatedIntakes);
        
        emit(CreateMealLoaded(
          intakes: updatedIntakes,
          totalKcal: newTotals.kcal,
          totalCarbs: newTotals.carbs,
          totalFat: newTotals.fat,
          totalProtein: newTotals.protein,
        ));
      }
    });

    on<ClearIntakeListEvent>((event, emit) {
      emit(CreateMealLoaded(
        intakes: const [],
        totalKcal: 0,
        totalCarbs: 0,
        totalFat: 0,
        totalProtein: 0,
      ));
    });

    on<UpdateIntakeAmountEvent>((event, emit) {
      if (state is CreateMealLoaded) {
        final currentState = state as CreateMealLoaded;
        final List<IntakeEntity> updatedIntakes = List.from(currentState.intakes);
        
        // Find the intake to update
        final intakeIndex = updatedIntakes.indexWhere((intake) => intake.id == event.intakeId);
        
        if (intakeIndex != -1) {
          // Create a new intake with updated amount
          final oldIntake = updatedIntakes[intakeIndex];
          final updatedIntake = IntakeEntity(
            id: oldIntake.id,
            unit: oldIntake.unit,
            amount: event.newAmount,
            type: oldIntake.type,
            meal: oldIntake.meal,
            dateTime: oldIntake.dateTime,
          );
          
          // Replace the old intake with the updated one
          updatedIntakes[intakeIndex] = updatedIntake;
          
          // Calculate new totals
          final newTotals = _calculateTotals(updatedIntakes);
          
          emit(CreateMealLoaded(
            intakes: updatedIntakes,
            totalKcal: newTotals.kcal,
            totalCarbs: newTotals.carbs,
            totalFat: newTotals.fat,
            totalProtein: newTotals.protein,
          ));
        }
      }
    });

    on<RemoveIntakeEvent>((event, emit) {
      if (state is CreateMealLoaded) {
        final currentState = state as CreateMealLoaded;
        final List<IntakeEntity> updatedIntakes = List.from(currentState.intakes);
        
        // Remove the intake with the matching code
        updatedIntakes.removeWhere((intake) => intake.meal.code == event.code);
        
        // Calculate new totals
        final newTotals = _calculateTotals(updatedIntakes);
        
        emit(CreateMealLoaded(
          intakes: updatedIntakes,
          totalKcal: newTotals.kcal,
          totalCarbs: newTotals.carbs,
          totalFat: newTotals.fat,
          totalProtein: newTotals.protein,
        ));
      }
    });
  }
  
  _MacroTotals _calculateTotals(List<IntakeEntity> intakes) {
    double totalKcal = 0;
    double totalCarbs = 0;
    double totalFat = 0;
    double totalProtein = 0;
    
    for (final intake in intakes) {
      totalKcal += intake.totalKcal;
      totalCarbs += intake.totalCarbsGram;
      totalFat += intake.totalFatsGram;
      totalProtein += intake.totalProteinsGram;
    }
    
    return _MacroTotals(
      kcal: totalKcal,
      carbs: totalCarbs,
      fat: totalFat,
      protein: totalProtein,
    );
  }
}

class _MacroTotals {
  final double kcal;
  final double carbs;
  final double fat;
  final double protein;
  
  _MacroTotals({
    required this.kcal,
    required this.carbs,
    required this.fat,
    required this.protein,
  });
}