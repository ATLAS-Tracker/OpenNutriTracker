part of 'recipe_bloc.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();
}

class RecipeInitial extends RecipeState {
  @override
  List<Object> get props => [];
}

class RecipeLoadingState extends RecipeState {
  @override
  List<Object?> get props => [];
}

class RecipeLoadedState extends RecipeState {
  final List<MealEntity> recipes;
  final bool usesImperialUnits;

  const RecipeLoadedState(
      {required this.recipes, this.usesImperialUnits = false});

  @override
  List<Object?> get props => [recipes, usesImperialUnits];
}

class RecipeFailedState extends RecipeState {
  @override
  List<Object?> get props => [];
}
