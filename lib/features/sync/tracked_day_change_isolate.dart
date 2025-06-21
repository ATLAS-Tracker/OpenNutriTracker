import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:opennutritracker/core/data/dbo/tracked_day_dbo.dart';
import 'package:opennutritracker/core/utils/extensions.dart';
import 'package:opennutritracker/features/sync/change_isolate.dart';
import 'package:opennutritracker/features/sync/supabase_client.dart';

/// Watches a [TrackedDayDBO] box and collects modified day values in a
/// background isolate.
class TrackedDayChangeIsolate extends ChangeIsolate<DateTime> {
  final SupabaseTrackedDayService _service;
  final Connectivity _connectivity;
  final int batchSize;
  StreamSubscription<ConnectivityResult>? _connectivitySub;
  bool _syncing = false;

  TrackedDayChangeIsolate(
    Box<TrackedDayDBO> box, {
    SupabaseTrackedDayService? service,
    Connectivity? connectivity,
    this.batchSize = 20,
  })  : _service = service ?? SupabaseTrackedDayService(),
        _connectivity = connectivity ?? Connectivity(),
        super(
          box: box,
          extractor: (event) {
            final value = event.value;
            if (value is TrackedDayDBO) {
              return value.day;
            }
            return null;
          },
        );

  /// Convenience method that forwards to [getItems].
  Future<List<DateTime>> getModifiedDays() => getItems();

  @override
  Future<void> start() async {
    await super.start();
    _connectivitySub =
        _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
  }

  @override
  Future<void> stop() async {
    await _connectivitySub?.cancel();
    _connectivitySub = null;
    await super.stop();
  }

  void _onConnectivityChanged(ConnectivityResult result) {
    if (result != ConnectivityResult.none) {
      _attemptSync();
    }
  }

  Future<void> _attemptSync() async {
    if (_syncing) return;
    if (await _connectivity.checkConnectivity() == ConnectivityResult.none) {
      return;
    }
    final days = await getModifiedDays();
    if (days.isEmpty) return;
    _syncing = true;
    try {
      for (var i = 0; i < days.length; i += batchSize) {
        final batch = days.skip(i).take(batchSize).toList();
        final entries = <Map<String, dynamic>>[];
        for (final day in batch) {
          final dbo = box.get(day.toParsedDay()) as TrackedDayDBO?;
          if (dbo != null) {
            entries.add(dbo.toJson());
          }
        }
        if (entries.isNotEmpty) {
          if (await _connectivity.checkConnectivity() ==
              ConnectivityResult.none) {
            break;
          }
          await _service.upsertTrackedDays(entries);
        }
        await removeItems(batch);
      }
    } finally {
      _syncing = false;
    }
  }
}
