import 'package:flutter/material.dart';
import 'package:opennutritracker/features/diary/presentation/widgets/diary_table_calendar.dart';
import 'package:opennutritracker/core/domain/entity/tracked_day_entity.dart';
import 'package:opennutritracker/core/domain/entity/intake_type_entity.dart';
import 'package:opennutritracker/generated/l10n.dart';

class CalendarMealTypeSelector extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const CalendarMealTypeSelector({super.key, required this.onDateSelected});

  @override
  State<CalendarMealTypeSelector> createState() =>
      _CalendarMealTypeSelectorState();
}

class _CalendarMealTypeSelectorState extends State<CalendarMealTypeSelector> {
  late DateTime _selectedDate;
  int _currentMealIndex = 0;

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
        ],
      ),
    );
  }
}
