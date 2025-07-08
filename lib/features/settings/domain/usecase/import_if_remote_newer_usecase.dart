import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:opennutritracker/features/settings/domain/usecase/import_data_supabase_usecase.dart';
import 'package:opennutritracker/core/data/repository/config_repository.dart';

/// Checks the timestamp of the remote backup and imports it if newer than
/// local data.
class ImportIfRemoteNewerUsecase {
  final SupabaseClient _client;
  final ImportDataSupabaseUsecase _importDataSupabaseUsecase;
  final ConfigRepository _configRepository;
  final _log = Logger('ImportIfRemoteNewerUsecase');

  ImportIfRemoteNewerUsecase(
    this._client,
    this._importDataSupabaseUsecase,
    this._configRepository,
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
      final localDate = await _configRepository.getLastDataUpdate();
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

}
