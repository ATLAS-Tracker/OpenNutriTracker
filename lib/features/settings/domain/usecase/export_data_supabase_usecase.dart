import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:opennutritracker/core/data/repository/intake_repository.dart';
import 'package:opennutritracker/core/data/repository/tracked_day_repository.dart';
import 'package:opennutritracker/core/data/repository/user_activity_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Exports user data to a zip file and uploads it to Supabase storage.
class ExportDataSupabaseUsecase {
  final UserActivityRepository _userActivityRepository;
  final IntakeRepository _intakeRepository;
  final TrackedDayRepository _trackedDayRepository;
  final SupabaseClient _client;

  ExportDataSupabaseUsecase(this._userActivityRepository, this._intakeRepository,
      this._trackedDayRepository, this._client);

  /// Creates a zipped backup and uploads it to Supabase storage.
  Future<bool> exportData(
    String exportZipFileName,
    String userActivityJsonFileName,
    String userIntakeJsonFileName,
    String trackedDayJsonFileName,
  ) async {
    // Export user activity data to Json File Bytes
    final fullUserActivity =
        await _userActivityRepository.getAllUserActivityDBO();
    final fullUserActivityJson = jsonEncode(
        fullUserActivity.map((activity) => activity.toJson()).toList());
    final userActivityJsonBytes = utf8.encode(fullUserActivityJson);

    // Export intake data to Json File Bytes
    final fullIntake = await _intakeRepository.getAllIntakesDBO();
    final fullIntakeJson =
        jsonEncode(fullIntake.map((intake) => intake.toJson()).toList());
    final intakeJsonBytes = utf8.encode(fullIntakeJson);

    // Export tracked day data to Json File Bytes
    final fullTrackedDay = await _trackedDayRepository.getAllTrackedDaysDBO();
    final fullTrackedDayJson = jsonEncode(
        fullTrackedDay.map((trackedDay) => trackedDay.toJson()).toList());
    final trackedDayJsonBytes = utf8.encode(fullTrackedDayJson);

    // Create a zip file with the exported data
    final archive = Archive()
      ..addFile(ArchiveFile(userActivityJsonFileName,
          userActivityJsonBytes.length, userActivityJsonBytes))
      ..addFile(ArchiveFile(
          userIntakeJsonFileName, intakeJsonBytes.length, intakeJsonBytes))
      ..addFile(ArchiveFile(trackedDayJsonFileName, trackedDayJsonBytes.length,
          trackedDayJsonBytes));

    final zipBytes = ZipEncoder().encode(archive);

    final userId = _client.auth.currentUser?.id ?? 'unknown';
    final filePath = '$userId/$exportZipFileName';
    try {
      await _client.storage
          .from('exports')
          .uploadBinary(filePath, Uint8List.fromList(zipBytes),
              fileOptions: const FileOptions(contentType: 'application/zip'));
      return true;
    } catch (_) {
      return false;
    }
  }
}
