import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:opennutritracker/core/utils/locator.dart';
import 'package:opennutritracker/features/recipe/presentation/bloc/recipe_bloc.dart';
import 'package:opennutritracker/features/add_meal/presentation/recipe_results_list.dart';
import 'package:opennutritracker/features/add_meal/presentation/add_meal_type.dart';
import 'package:opennutritracker/features/add_meal/presentation/bloc/recipe_search_bloc.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipeState();
}

class _RecipeState extends State<RecipePage> {
  final log = Logger('RecipePage');
  late RecipeBloc _recipeBloc;
  late RecipeSearchBloc _recipeSearchBloc;

  @override
  void initState() {
    _recipeBloc = locator<RecipeBloc>();
    _recipeSearchBloc = locator<RecipeSearchBloc>();
    _recipeSearchBloc.add(const LoadRecipeSearchEvent(searchString: ""));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RecipeResultsList(
      day: DateTime.now(),
      mealType: AddMealType.snackType,
      bloc: _recipeSearchBloc,
    );
  }
}
