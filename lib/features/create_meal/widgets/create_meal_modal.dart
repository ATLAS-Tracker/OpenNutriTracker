import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opennutritracker/features/diary/presentation/widgets/diary_table_calendar.dart';
import 'package:opennutritracker/core/domain/entity/tracked_day_entity.dart';
import 'package:opennutritracker/core/domain/entity/intake_type_entity.dart';
import 'package:opennutritracker/generated/l10n.dart';
import 'package:opennutritracker/core/utils/locator.dart';
import 'package:opennutritracker/features/create_meal/presentation/bloc/create_meal_bloc.dart';
import 'package:opennutritracker/features/meal_detail/presentation/bloc/meal_detail_bloc.dart';
import 'package:opennutritracker/features/add_meal/domain/entity/meal_entity.dart';
import 'package:opennutritracker/core/utils/id_generator.dart';
import 'package:opennutritracker/features/add_meal/domain/entity/meal_nutriments_entity.dart';
import 'package:logging/logging.dart';
import 'package:opennutritracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:opennutritracker/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:opennutritracker/features/diary/presentation/bloc/calendar_day_bloc.dart';

class CalendarMealTypeSelector extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final String mealName;

  const CalendarMealTypeSelector({
    super.key,
    required this.onDateSelected,
    required this.mealName,
  });

  @override
  State<CalendarMealTypeSelector> createState() =>
      _CalendarMealTypeSelectorState();
}

class _CalendarMealTypeSelectorState extends State<CalendarMealTypeSelector> {
  late DateTime _selectedDate;
  int _currentMealIndex = 0;
  final _log = Logger('ConfigDataSource');

  final List<IntakeTypeEntity> _mealTypes = IntakeTypeEntity.values;

  late final TextEditingController mealPortionCountController;
  late final TextEditingController portionsEatenController;

  bool isSaveEnabled = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();

    mealPortionCountController = TextEditingController();
    portionsEatenController = TextEditingController();

    mealPortionCountController.addListener(_validateInputs);
    portionsEatenController.addListener(() {
      _validatePortions();
      _validateInputs();
    });
  }

  @override
  void dispose() {
    mealPortionCountController.dispose();
    portionsEatenController.dispose();
    super.dispose();
  }

  void _validatePortions() {
    final total = int.tryParse(mealPortionCountController.text) ?? 0;
    final eaten = int.tryParse(portionsEatenController.text) ?? 0;

    if (eaten > total && total > 0) {
      portionsEatenController.text = total.toString();
      portionsEatenController.selection = TextSelection.fromPosition(
        TextPosition(offset: portionsEatenController.text.length),
      );
    }
  }

  bool _areInputsValid() {
    final mealPortion = int.tryParse(mealPortionCountController.text) ?? 0;
    final eaten = int.tryParse(portionsEatenController.text) ?? 0;
    return mealPortion > 0 && eaten > 0;
  }

  void _validateInputs() {
    final isValid = _areInputsValid();
    if (isSaveEnabled != isValid) {
      setState(() {
        isSaveEnabled = isValid;
      });
    }
  }

  void _handleDateSelected(DateTime day, Map<String, TrackedDayEntity> _) {
    setState(() {
      _selectedDate = day;
    });
    widget.onDateSelected(day);
  }

  void _goToPreviousMeal() {
    setState(() {
      _currentMealIndex =
          (_currentMealIndex - 1 + _mealTypes.length) % _mealTypes.length;
    });
  }

  void _goToNextMeal() {
    setState(() {
      _currentMealIndex = (_currentMealIndex + 1) % _mealTypes.length;
    });
  }

  String _getMealLabel(IntakeTypeEntity type) {
    switch (type) {
      case IntakeTypeEntity.breakfast:
        return S.of(context).breakfastLabel;
      case IntakeTypeEntity.lunch:
        return S.of(context).lunchLabel;
      case IntakeTypeEntity.dinner:
        return S.of(context).dinnerLabel;
      case IntakeTypeEntity.snack:
        return S.of(context).snackLabel;
    }
  }

  void _onSavePressed() {
    final mealPortionCount = mealPortionCountController.text;
    final portionsEaten = portionsEatenController.text;

    final macros = locator<CreateMealBloc>().computeMacros();

    final nutriment = MealNutrimentsEntity(
        energyKcal100: macros['totalKcal'],
        carbohydrates100: macros['totalCarbs'],
        fat100: macros['totalFats'],
        proteins100: macros['totalProteins'],
        sugars100: null,
        saturatedFat100: null,
        fiber100: null);

    final meal = MealEntity(
      code: IdGenerator.getUniqueID(),
      name: widget.mealName,
      brands: "",
      url: "https://picsum.photos/200",
      thumbnailImageUrl: "https://picsum.photos/200",
      mainImageUrl: "https://picsum.photos/200",
      mealQuantity: mealPortionCount,
      mealUnit: "serving",
      servingQuantity: null,
      servingUnit: "serving",
      servingSize: "",
      nutriments: nutriment,
      source: MealSourceEntity.custom,
    );

    // TODO optimize this
    final portionRatio = (int.tryParse(portionsEaten) ?? 0) /
        (int.tryParse(mealPortionCount) ?? 1);
    final portionRatioString = portionRatio.toString();

    locator<MealDetailBloc>().addIntake(
      context,
      'serving',
      portionRatioString,
      _mealTypes[_currentMealIndex],
      meal,
      _selectedDate,
    );

    // Clean the list of intake
    locator<CreateMealBloc>().clearIntakeList();

    locator<HomeBloc>().add(const LoadItemsEvent());
    locator<DiaryBloc>().add(const LoadDiaryYearEvent());
    locator<CalendarDayBloc>().add(RefreshCalendarDayEvent());

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final currentMeal = _mealTypes[_currentMealIndex];

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Meal type selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _goToPreviousMeal,
                icon: const Icon(Icons.chevron_left),
              ),
              Row(
                children: [
                  Icon(currentMeal.getIconData()),
                  const SizedBox(width: 8),
                  Text(
                    _getMealLabel(currentMeal),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              IconButton(
                onPressed: _goToNextMeal,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 16),

          /// Portion inputs
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: mealPortionCountController,
                  decoration: const InputDecoration(
                    labelText: "Meal portion count",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: portionsEatenController,
                  decoration: const InputDecoration(
                    labelText: "Portions eaten",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
            ],
          ),

          /// Calendar
          DiaryTableCalendar(
            onDateSelected: _handleDateSelected,
            calendarDurationDays: const Duration(days: 30),
            focusedDate: _selectedDate,
            currentDate: DateTime.now(),
            selectedDate: _selectedDate,
            trackedDaysMap: const {},
          ),
          const SizedBox(height: 16),

          /// Save button
          FilledButton(
            onPressed: isSaveEnabled ? _onSavePressed : null,
            child: Text(S.of(context).buttonSaveLabel),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
