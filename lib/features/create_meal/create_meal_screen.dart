import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:opennutritracker/core/utils/navigation_options.dart';
import 'package:opennutritracker/generated/l10n.dart';
import 'package:opennutritracker/features/add_meal/presentation/add_meal_type.dart';
import 'package:opennutritracker/features/add_meal/presentation/add_meal_screen.dart';
import 'package:opennutritracker/core/utils/locator.dart';
import 'package:opennutritracker/features/create_meal/presentation/bloc/create_meal_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opennutritracker/features/home/presentation/widgets/intake_vertical_list.dart';
import 'package:opennutritracker/core/domain/entity/intake_type_entity.dart';
import 'package:opennutritracker/core/domain/entity/intake_entity.dart';

class MealCreationScreen extends StatefulWidget {
  const MealCreationScreen({super.key});

  @override
  State<MealCreationScreen> createState() => _MealCreationScreenState();
}

class _MealCreationScreenState extends State<MealCreationScreen> {
  final log = Logger('MealCreationScreen');
  late final CreateMealBloc _createMealBloc;

  @override
  void initState() {
    super.initState();
    _createMealBloc = locator<CreateMealBloc>();
    _createMealBloc.add(InitializeCreateMealEvent());
    log.info(
        "InitializeCreateMealEvent added: isOnCreateMealScreen set to true");
  }

  @override
  void dispose() {
    _createMealBloc.add(ExitCreateMealScreenEvent());
    log.info(
        "ExitCreateMealScreenEvent added: isOnCreateMealScreen set to false");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add meal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<CreateMealBloc, CreateMealState>(
              bloc: _createMealBloc,
              builder: (context, state) {
                if (state.intakeList.isEmpty) {
                  return const Text("Aucun intake ajouté.");
                }

                return IntakeVerticalList(
                  day: DateTime.now(),
                  title: S.of(context).snackLabel,
                  addMealType: AddMealType.dinnerType,
                  listIcon: IntakeTypeEntity.snack.getIconData(),
                  intakeList: state.intakeList,
                  onItemDragCallback: onIntakeItemDrag,
                  onItemTappedCallback: onIntakeItemTapped,
                  usesImperialUnits: true,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _showAddItemScreen(context, AddMealType.snackType, DateTime.now()),
        tooltip: S.of(context).addLabel,
        child: const Icon(Icons.add),
      ),
    );
  }

  void onIntakeItemDrag(bool isDragging) {
    // TODO
  }

  void onIntakeItemTapped(BuildContext context, IntakeEntity intakeEntity,
      bool usesImperialUnits) async {
    // TODO
  }

  void _showAddItemScreen(
      BuildContext context, AddMealType itemType, DateTime day) {
    Navigator.of(context).pushNamed(
      NavigationOptions.addMealRoute,
      arguments: AddMealScreenArguments(
        itemType,
        day,
      ),
    );
  }
}
