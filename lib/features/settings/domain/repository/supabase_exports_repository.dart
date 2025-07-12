import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Helper for interacting with the backup stored in Supabase.
class SupabaseExportsRepository {
  final SupabaseClient _client;
  final _log = Logger('SupabaseExportsRepository');

  SupabaseExportsRepository(this._client);

  /// Returns the file for [fileName] in the "exports" bucket for [userId],
  /// or `null` if none exists or the request fails.
  Future<FileObject?> fetchExportFile(String userId, String fileName) async {
    try {
      final files = await _client.storage.from('exports').list(path: userId);
      return files.firstWhereOrNull((f) => f.name == fileName);
    } catch (e, stack) {
      _log.warning('Failed to list exports', e, stack);
      return null;
    }
  }

  /// Extracts the timestamp from [file] using either the `lastDataUpdate`
  /// metadata or the `updatedAt` field. Returns `null` if neither is available.
  DateTime? fileTimestamp(FileObject file) {
    final metaDateStr = file.metadata?['lastDataUpdate'];
    if (metaDateStr is String) {
      final metaDate = DateTime.tryParse(metaDateStr);
      if (metaDate != null) return metaDate;
    }
    if (file.updatedAt != null) {
      return DateTime.tryParse(file.updatedAt!);
    }
    return null;
  }

  /// Convenience method combining [fetchExportFile] and [fileTimestamp].
  Future<DateTime?> fetchExportTimestamp(String userId, String fileName) async {
    final file = await fetchExportFile(userId, fileName);
    return file == null ? null : fileTimestamp(file);
  }
}
