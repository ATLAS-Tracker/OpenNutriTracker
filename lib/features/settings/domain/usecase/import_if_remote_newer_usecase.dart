import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:opennutritracker/features/settings/domain/usecase/import_data_supabase_usecase.dart';
import 'package:opennutritracker/core/data/repository/intake_repository.dart';
import 'package:opennutritracker/core/data/repository/user_activity_repository.dart';
import 'package:opennutritracker/core/data/repository/tracked_day_repository.dart';
import 'package:opennutritracker/core/data/repository/user_weight_repository.dart';

/// Checks the timestamp of the remote backup and imports it if newer than
/// local data.
class ImportIfRemoteNewerUsecase {
  final SupabaseClient _client;
  final ImportDataSupabaseUsecase _importDataSupabaseUsecase;
  final IntakeRepository _intakeRepository;
  final UserActivityRepository _userActivityRepository;
  final TrackedDayRepository _trackedDayRepository;
  final UserWeightRepository _userWeightRepository;
  final _log = Logger('ImportIfRemoteNewerUsecase');

  ImportIfRemoteNewerUsecase(
    this._client,
    this._importDataSupabaseUsecase,
    this._intakeRepository,
    this._userActivityRepository,
    this._trackedDayRepository,
    this._userWeightRepository,
  );

  Future<void> maybeImport(
    String exportZipFileName,
    String userActivityJsonFileName,
    String userIntakeJsonFileName,
    String trackedDayJsonFileName,
    String userWeightJsonFileName,
  ) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      _log.warning('No Supabase session – aborting maybeImport');
      return;
    }

    try {
      final storage = _client.storage.from('exports');
      final files = await storage.list(path: userId);
      final file = files.firstWhereOrNull((f) => f.name == exportZipFileName);
      if (file == null || file.updatedAt == null) {
        return;
      }
      final remoteDate = DateTime.parse(file.updatedAt!);
      final localDate = await _getLatestLocalUpdate();
      if (localDate == null || remoteDate.isAfter(localDate)) {
        await _importDataSupabaseUsecase.importData(
          exportZipFileName,
          userActivityJsonFileName,
          userIntakeJsonFileName,
          trackedDayJsonFileName,
          userWeightJsonFileName,
        );
      }
    } catch (e, stack) {
      _log.warning('maybeImport failed', e, stack);
    }
  }

  Future<DateTime?> _getLatestLocalUpdate() async {
    DateTime? latest;

    void check(DateTime? d) {
      if (d == null) return;
      if (latest == null || d.isAfter(latest!)) latest = d;
    }

    final activities = await _userActivityRepository.getAllUserActivityDBO();
    for (final a in activities) {
      check(a.updatedAt);
    }

    final intakes = await _intakeRepository.getAllIntakesDBO();
    for (final i in intakes) {
      check(i.updatedAt);
    }

    final days = await _trackedDayRepository.getAllTrackedDaysDBO();
    for (final d in days) {
      check(d.updatedAt);
    }

    final weights = await _userWeightRepository.getAllUserWeightDBOs();
    for (final w in weights) {
      check(w.updatedAt);
    }

    return latest;
  }
}
