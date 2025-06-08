import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:opennutritracker/core/data/dbo/intake_dbo.dart';
import 'package:opennutritracker/services/sync/sync_action.dart';

class SyncQueueService {
  final Box<IntakeDBO> _intakeBox;
  final Box<SyncAction> _queueBox;

  final Map<dynamic, IntakeDBO> _cache = {};
  StreamSubscription<BoxEvent>? _sub;

  SyncQueueService(this._intakeBox, this._queueBox);

  Future<void> start() async {
    _cache.clear();
    _cache.addAll(_intakeBox.toMap().cast<dynamic, IntakeDBO>());
    _sub = _intakeBox.watch().listen(_onEvent);
  }

  Future<void> dispose() async {
    await _sub?.cancel();
  }

  void _onEvent(BoxEvent event) {
    if (event.deleted) {
      final old = _cache.remove(event.key);
      if (old != null) {
        _queueBox.add(SyncAction(
          action: 'delete',
          table: 'intakes',
          id: old.id,
        ));
      }
    } else {
      final intake = event.value as IntakeDBO;
      final actionName = _cache.containsKey(event.key) ? 'update' : 'create';
      _cache[event.key] = intake;
      _queueBox.add(SyncAction(
        action: actionName,
        table: 'intakes',
        data: intake.toJson(),
        id: intake.id,
      ));
    }
  }
}
