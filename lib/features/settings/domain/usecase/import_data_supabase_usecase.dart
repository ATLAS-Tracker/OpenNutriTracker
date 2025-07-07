import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:opennutritracker/core/data/data_source/user_activity_dbo.dart';
import 'package:opennutritracker/core/data/dbo/intake_dbo.dart';
import 'package:opennutritracker/core/data/dbo/tracked_day_dbo.dart';
import 'package:opennutritracker/core/data/data_source/user_weight_dbo.dart';
import 'package:opennutritracker/core/data/repository/intake_repository.dart';
import 'package:opennutritracker/core/data/repository/tracked_day_repository.dart';
import 'package:opennutritracker/core/data/repository/user_activity_repository.dart';
import 'package:opennutritracker/core/data/repository/user_weight_repository.dart';

/// Imports user data from a zip stored on Supabase storage.
/// Existing entries are replaced if the incoming entry has a more recent
/// `updatedAt` field.
class ImportDataSupabaseUsecase {
  final UserActivityRepository _userActivityRepository;
  final IntakeRepository _intakeRepository;
  final TrackedDayRepository _trackedDayRepository;
  final UserWeightRepository _userWeightRepository;
  final SupabaseClient _client;
  final _log = Logger('ImportDataSupabaseUsecase');

  ImportDataSupabaseUsecase(
    this._userActivityRepository,
    this._intakeRepository,
    this._trackedDayRepository,
    this._userWeightRepository,
    this._client,
  );

  Future<bool> importData(
    String exportZipFileName,
    String userActivityJsonFileName,
    String userIntakeJsonFileName,
    String trackedDayJsonFileName,
    String userWeightJsonFileName,
  ) async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) {
        _log.warning('No Supabase session – aborting import');
        return false;
      }

      final filePath = '$userId/$exportZipFileName';
      final data = await _client.storage.from('exports').download(filePath);
      final archive = ZipDecoder().decodeBytes(data);

      // ----- USER ACTIVITY -----
      final userActivityFile = archive.findFile(userActivityJsonFileName);
      if (userActivityFile == null) {
        throw Exception('User activity file not found');
      }
      final userActivityJsonString = utf8.decode(
        userActivityFile.content as List<int>,
      );
      final userActivityList = (jsonDecode(userActivityJsonString) as List)
          .cast<Map<String, dynamic>>();
      final userActivityDBOs =
          userActivityList.map((e) => UserActivityDBO.fromJson(e)).toList();

      final existingActivities =
          await _userActivityRepository.getAllUserActivityDBO();
      final activityMap = {for (final a in existingActivities) a.id: a};

      final List<UserActivityDBO> activitiesToSave = [];
      final List<String> activityIdsToDelete = [];
      for (final dbo in userActivityDBOs) {
        final current = activityMap[dbo.id];
        if (current == null) {
          activitiesToSave.add(dbo);
        } else if (dbo.updatedAt.isAfter(current.updatedAt)) {
          activityIdsToDelete.add(current.id);
          activitiesToSave.add(dbo);
        }
      }
      if (activitiesToSave.isNotEmpty) {
        await _userActivityRepository.addAllUserActivityDBOs(activitiesToSave);
      }
      if (activityIdsToDelete.isNotEmpty) {
        await _userActivityRepository.deleteUserActivitiesByIds(
          activityIdsToDelete,
        );
      }

      // ----- INTAKES -----
      final intakeFile = archive.findFile(userIntakeJsonFileName);
      if (intakeFile == null) {
        throw Exception('Intake file not found');
      }
      final intakeJsonString = utf8.decode(intakeFile.content as List<int>);
      final intakeList =
          (jsonDecode(intakeJsonString) as List).cast<Map<String, dynamic>>();
      final intakeDBOs = intakeList.map((e) => IntakeDBO.fromJson(e)).toList();

      final existingIntakes = await _intakeRepository.getAllIntakesDBO();
      final intakeMap = {for (final i in existingIntakes) i.id: i};

      final List<IntakeDBO> intakesToSave = [];
      final List<String> intakeIdsToDelete = [];
      for (final dbo in intakeDBOs) {
        final current = intakeMap[dbo.id];
        if (current == null) {
          intakesToSave.add(dbo);
        } else if (dbo.updatedAt.isAfter(current.updatedAt)) {
          intakeIdsToDelete.add(current.id);
          intakesToSave.add(dbo);
        }
      }
      if (intakesToSave.isNotEmpty) {
        await _intakeRepository.addAllIntakeDBOs(intakesToSave);
      }
      if (intakeIdsToDelete.isNotEmpty) {
        await _intakeRepository.deleteIntakesByIds(intakeIdsToDelete);
      }

      // ----- TRACKED DAYS -----
      final trackedDayFile = archive.findFile(trackedDayJsonFileName);
      if (trackedDayFile == null) {
        throw Exception('Tracked day file not found');
      }
      final trackedDayJsonString = utf8.decode(
        trackedDayFile.content as List<int>,
      );
      final trackedDayList = (jsonDecode(trackedDayJsonString) as List)
          .cast<Map<String, dynamic>>();
      final trackedDayDBOs =
          trackedDayList.map((e) => TrackedDayDBO.fromJson(e)).toList();

      final existingDays = await _trackedDayRepository.getAllTrackedDaysDBO();
      final dayMap = {for (final d in existingDays) d.day.toIso8601String(): d};
      final List<TrackedDayDBO> daysToSave = [];
      for (final dbo in trackedDayDBOs) {
        final key = dbo.day.toIso8601String();
        final current = dayMap[key];
        if (current == null || dbo.updatedAt.isAfter(current.updatedAt)) {
          daysToSave.add(dbo);
        }
      }
      if (daysToSave.isNotEmpty) {
        await _trackedDayRepository.addAllTrackedDays(daysToSave);
      }

      // ----- USER WEIGHT -----
      final userWeightFile = archive.findFile(userWeightJsonFileName);
      if (userWeightFile == null) {
        throw Exception('User weight file not found');
      }
      final userWeightJsonString = utf8.decode(
        userWeightFile.content as List<int>,
      );
      final userWeightList = (jsonDecode(userWeightJsonString) as List)
          .cast<Map<String, dynamic>>();
      final userWeightDBOs =
          userWeightList.map((e) => UserWeightDbo.fromJson(e)).toList();

      final existingWeights =
          await _userWeightRepository.getAllUserWeightDBOs();
      final weightMap = {
        for (final w in existingWeights)
          DateTime(w.date.year, w.date.month, w.date.day).toIso8601String(): w,
      };

      final List<UserWeightDbo> weightsToSave = [];
      for (final dbo in userWeightDBOs) {
        final key = DateTime(
          dbo.date.year,
          dbo.date.month,
          dbo.date.day,
        ).toIso8601String();
        final current = weightMap[key];
        if (current == null) {
          weightsToSave.add(dbo);
        } else if (dbo.updatedAt.isAfter(current.updatedAt)) {
          weightsToSave.add(dbo);
        }
      }
      if (weightsToSave.isNotEmpty) {
        await _userWeightRepository.addAllUserWeightDBOs(weightsToSave);
      }

      return true;
    } catch (e, stack) {
      _log.severe('Failed to import from Supabase', e, stack);
      return false;
    }
  }
}
