import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opennutritracker/core/presentation/widgets/error_dialog.dart';
import 'package:opennutritracker/features/add_meal/presentation/bloc/recipe_search_bloc.dart';
import 'package:opennutritracker/features/add_meal/presentation/widgets/meal_item_card.dart';
import 'package:opennutritracker/features/add_meal/presentation/widgets/default_results_widget.dart';
import 'package:opennutritracker/features/add_meal/presentation/widgets/no_results_widget.dart';
import 'package:opennutritracker/features/add_meal/presentation/add_meal_type.dart';

class RecipeResultsList extends StatefulWidget {
  final DateTime day;
  final AddMealType mealType;
  final RecipeSearchBloc bloc;

  const RecipeResultsList({
    super.key,
    required this.day,
    required this.mealType,
    required this.bloc,
  });

  @override
  State<RecipeResultsList> createState() => _RecipeResultsListState();
}

class _RecipeResultsListState extends State<RecipeResultsList> {
  void _onRecipeRefreshButtonPressed() {
    widget.bloc.add(const LoadRecipeSearchEvent(searchString: ""));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<RecipeSearchBloc, RecipeSearchState>(
          bloc: widget.bloc,
          builder: (context, state) {
            if (state is RecipeInitial) {
              return const DefaultsResultsWidget();
            } else if (state is RecipeLoadingState) {
              return const Padding(
                padding: EdgeInsets.only(top: 32),
                child: CircularProgressIndicator(),
              );
            } else if (state is RecipeLoadedState) {
              return state.recipes.isNotEmpty
                  ? Flexible(
                      child: ListView.builder(
                        itemCount: state.recipes.length,
                        itemBuilder: (context, index) {
                          return MealItemCard(
                            day: widget.day,
                            mealEntity: state.recipes[index],
                            addMealType: widget.mealType,
                            usesImperialUnits: state.usesImperialUnits,
                          );
                        },
                      ),
                    )
                  : const NoResultsWidget();
            } else if (state is RecipeFailedState) {
              return ErrorDialog(
                errorText: "Aucune recette trouvée",
                onRefreshPressed: _onRecipeRefreshButtonPressed,
              );
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }
}
