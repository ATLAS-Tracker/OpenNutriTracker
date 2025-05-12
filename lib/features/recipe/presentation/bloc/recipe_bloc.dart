import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'recipe_event.dart';

part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(RecipeInitial()) {
    on<LoadRecipeEvent>((event, emit) async {
      emit(RecipeLoadingState());
      emit(RecipeLoadedState(usesImperialUnits: false));
    });
  }
}
