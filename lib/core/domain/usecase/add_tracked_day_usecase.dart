import 'package:opennutritracker/core/data/repository/tracked_day_repository.dart';
import 'package:opennutritracker/core/data/repository/config_repository.dart';

class AddTrackedDayUsecase {
  final TrackedDayRepository _trackedDayRepository;
  final ConfigRepository _configRepository;

  AddTrackedDayUsecase(this._trackedDayRepository, this._configRepository);

  Future<void> updateDayCalorieGoal(DateTime day, double calorieGoal) async {
    await _trackedDayRepository.updateDayCalorieGoal(day, calorieGoal);
    await _configRepository.setTrackedDayLastUpdate(DateTime.now());
  }

  Future<void> increaseDayCalorieGoal(DateTime day, double amount) async {
    await _trackedDayRepository.increaseDayCalorieGoal(day, amount);
    await _configRepository.setTrackedDayLastUpdate(DateTime.now());
  }

  Future<void> reduceDayCalorieGoal(DateTime day, double amount) async {
    await _trackedDayRepository.reduceDayCalorieGoal(day, amount);
    await _configRepository.setTrackedDayLastUpdate(DateTime.now());
  }

  Future<bool> hasTrackedDay(DateTime day) async {
    return await _trackedDayRepository.hasTrackedDay(day);
  }

  Future<void> addNewTrackedDay(
      DateTime day,
      double totalKcalGoal,
      double totalCarbsGoal,
      double totalFatGoal,
      double totalProteinGoal) async {
    await _trackedDayRepository.addNewTrackedDay(
        day, totalKcalGoal, totalCarbsGoal, totalFatGoal, totalProteinGoal);
    await _configRepository.setTrackedDayLastUpdate(DateTime.now());
  }

  Future<void> addDayCaloriesTracked(
      DateTime day, double caloriesTracked) async {
    _trackedDayRepository.addDayTrackedCalories(day, caloriesTracked);
    await _configRepository.setTrackedDayLastUpdate(DateTime.now());
  }

  Future<void> removeDayCaloriesTracked(
      DateTime day, double caloriesTracked) async {
    await _trackedDayRepository.removeDayTrackedCalories(day, caloriesTracked);
    await _configRepository.setTrackedDayLastUpdate(DateTime.now());
  }

  Future<void> updateDayMacroGoals(DateTime day,
      {double? carbsGoal, double? fatGoal, double? proteinGoal}) async {
    await _trackedDayRepository.updateDayMacroGoal(day,
        carbGoal: carbsGoal, fatGoal: fatGoal, proteinGoal: proteinGoal);
    await _configRepository.setTrackedDayLastUpdate(DateTime.now());
  }

  Future<void> increaseDayMacroGoals(DateTime day,
      {double? carbsAmount, double? fatAmount, double? proteinAmount}) async {
    await _trackedDayRepository.increaseDayMacroGoal(day,
        carbGoal: carbsAmount, fatGoal: fatAmount, proteinGoal: proteinAmount);
    await _configRepository.setTrackedDayLastUpdate(DateTime.now());
  }

  Future<void> reduceDayMacroGoals(DateTime day,
      {double? carbsAmount, double? fatAmount, double? proteinAmount}) async {
    await _trackedDayRepository.reduceDayMacroGoal(day,
        carbGoal: carbsAmount, fatGoal: fatAmount, proteinGoal: proteinAmount);
    await _configRepository.setTrackedDayLastUpdate(DateTime.now());
  }

  Future<void> addDayMacrosTracked(DateTime day,
      {double? carbsTracked, double? fatTracked, double? proteinTracked}) async {
    await _trackedDayRepository.addDayMacrosTracked(day,
        carbsTracked: carbsTracked, fatTracked: fatTracked, proteinTracked: proteinTracked);
    await _configRepository.setTrackedDayLastUpdate(DateTime.now());
  }

  Future<void> removeDayMacrosTracked(DateTime day,
      {double? carbsTracked, double? fatTracked, double? proteinTracked}) async {
    await _trackedDayRepository.removeDayMacrosTracked(day,
        carbsTracked: carbsTracked, fatTracked: fatTracked, proteinTracked: proteinTracked);
    await _configRepository.setTrackedDayLastUpdate(DateTime.now());
  }
}
