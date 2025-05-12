part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();
}

class LoadRecipeEvent extends RecipeEvent {
  final String searchString;

  /// an empty `searchString` will load all RecentMeal
  const LoadRecipeEvent({required this.searchString});

  @override
  List<Object?> get props => [];
}
