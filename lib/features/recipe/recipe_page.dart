import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:opennutritracker/core/utils/locator.dart';
import 'package:opennutritracker/features/recipe/presentation/bloc/recipe_bloc.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipeState();
}

class _RecipeState extends State<RecipePage> {
  final log = Logger('RecipePage');
  late RecipeBloc _recipeBloc;

  @override
  void initState() {
    _recipeBloc = locator<RecipeBloc>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
