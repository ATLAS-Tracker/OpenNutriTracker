import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opennutritracker/core/presentation/widgets/error_dialog.dart';
import 'package:opennutritracker/features/add_meal/presentation/bloc/recipe_search_bloc.dart';
import 'package:opennutritracker/features/add_meal/presentation/widgets/meal_item_card.dart';
import 'package:opennutritracker/features/add_meal/presentation/widgets/default_results_widget.dart';
import 'package:opennutritracker/features/add_meal/presentation/widgets/no_results_widget.dart';
import 'package:opennutritracker/features/add_meal/presentation/add_meal_type.dart';
import 'package:opennutritracker/core/domain/usecase/delete_intake_usecase.dart';
import 'package:opennutritracker/core/utils/locator.dart';
import 'package:logging/logging.dart';

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
  final _log = Logger('Recipe Result List');
  bool _isDragging = false;
  final DeleteIntakeUsecase _deleteIntakeUsecase =
      locator<DeleteIntakeUsecase>();

  void _onRecipeRefreshButtonPressed() {
    widget.bloc.add(const LoadRecipeSearchEvent(searchString: ""));
  }

  @override
  Widget build(BuildContext context) {
    _log.fine("Recipe result list build method");
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
                      child: Stack(
                        children: [
                          ListView.builder(
                            itemCount: state.recipes.length,
                            itemBuilder: (context, index) {
                              final recipe = state.recipes[index];
                              return LongPressDraggable(
                                data: recipe,
                                onDragStarted: () {
                                  setState(() {
                                    _isDragging = true;
                                  });
                                },
                                onDraggableCanceled: (_, __) {
                                  setState(() {
                                    _isDragging = false;
                                  });
                                },
                                onDragEnd: (_) {
                                  setState(() {
                                    _isDragging = false;
                                  });
                                },
                                feedback: Material(
                                  color: Colors.transparent,
                                  child: ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 300),
                                    child: Opacity(
                                      opacity: 0.85,
                                      child: MealItemCard(
                                        day: widget.day,
                                        mealEntity: recipe,
                                        addMealType: widget.mealType,
                                        usesImperialUnits:
                                            state.usesImperialUnits,
                                      ),
                                    ),
                                  ),
                                ),
                                childWhenDragging: Opacity(
                                  opacity: 0.3,
                                  child: MealItemCard(
                                    day: widget.day,
                                    mealEntity: recipe,
                                    addMealType: widget.mealType,
                                    usesImperialUnits: state.usesImperialUnits,
                                  ),
                                ),
                                child: MealItemCard(
                                  day: widget.day,
                                  mealEntity: recipe,
                                  addMealType: widget.mealType,
                                  usesImperialUnits: state.usesImperialUnits,
                                ),
                              );
                            },
                          ),
                          if (_isDragging)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 70,
                                color: Theme.of(context).colorScheme.error
                                  ..withValues(alpha: 0.3),
                                child: DragTarget(
                                  onWillAccept: (data) => true,
                                  onAccept: (data) {
                                    setState(() {
                                      _isDragging = false;
                                    });
                                    // Logique de suppression à implémenter plus tard
                                    // print("Suppression demandée pour $data");
                                  },
                                  onLeave: (data) {
                                    setState(() {
                                      _isDragging = false;
                                    });
                                  },
                                  builder:
                                      (context, candidateData, rejectedData) {
                                    return const Center(
                                      child: Icon(
                                        Icons.delete_outline,
                                        size: 36,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  : const Center(child: NoResultsWidget());
            } else if (state is RecipeFailedState) {
              return ErrorDialog(
                errorText: "Aucune recette trouvée",
                onRefreshPressed: _onRecipeRefreshButtonPressed,
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
