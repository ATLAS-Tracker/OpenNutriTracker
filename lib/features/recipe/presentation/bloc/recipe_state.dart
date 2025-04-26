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
  final bool usesImperialUnits;

  const RecipeLoadedState({
    required this.usesImperialUnits,
  });

  @override
  List<Object?> get props => [usesImperialUnits];
}
