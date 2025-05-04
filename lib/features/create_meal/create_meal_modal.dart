import 'package:flutter/material.dart';
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

class CalendarMealTypeSelector extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final String mealName;

  const CalendarMealTypeSelector(
      {super.key, required this.onDateSelected, required this.mealName});

  @override
  State<CalendarMealTypeSelector> createState() =>
      _CalendarMealTypeSelectorState();
}

class _CalendarMealTypeSelectorState extends State<CalendarMealTypeSelector> {
  late DateTime _selectedDate;
  int _currentMealIndex = 0;
  final _log = Logger('ConfigDataSource');

  final List<IntakeTypeEntity> _mealTypes = IntakeTypeEntity.values;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
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
    // TODO when there is nothing protect to not save

    final macros = locator<CreateMealBloc>().computeMacros();

    final nutriment = MealNutrimentsEntity(
        energyKcal100: null,
        carbohydrates100: macros['carbs'],
        fat100: macros['fats'],
        proteins100: macros['proteins'],
        sugars100: null,
        saturatedFat100: null,
        fiber100: null);

    final meal = MealEntity(
        code: IdGenerator.getUniqueID(),
        name: widget.mealName,
        brands: "",
        url: "",
        thumbnailImageUrl: "",
        mainImageUrl: "",
        mealQuantity: "",
        mealUnit: "",
        servingQuantity: null,
        servingUnit: "",
        servingSize: "",
        nutriments: nutriment,
        source: MealSourceEntity.custom);

    // locator<MealDetailBloc>().addIntake(context, 'g', '100',
    //     _mealTypes[_currentMealIndex], meal, _selectedDate);

    _log.fine(
        'Meal added: ${meal.name} (protein : ${meal.nutriments.proteins100}, carbs : ${meal.nutriments.carbohydrates100}, fats : ${meal.nutriments.fat100}) with type: ${_mealTypes[_currentMealIndex]} at $_selectedDate');
  }

  @override
  Widget build(BuildContext context) {
    final currentMeal = _mealTypes[_currentMealIndex];

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Sélecteur de type de repas
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

          /// Calendrier
          DiaryTableCalendar(
            onDateSelected: _handleDateSelected,
            calendarDurationDays: const Duration(days: 30),
            focusedDate: _selectedDate,
            currentDate: DateTime.now(),
            selectedDate: _selectedDate,
            trackedDaysMap: const {},
          ),
          const SizedBox(height: 16),
          FilledButton(
              onPressed: () => _onSavePressed(),
              child: Text(S.of(context).buttonSaveLabel)),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
