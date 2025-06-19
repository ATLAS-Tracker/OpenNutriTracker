import 'dart:isolate';
import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:opennutritracker/core/data/dbo/tracked_day_dbo.dart';

/// Handles modifications to [TrackedDayDBO] in a background isolate.
/// Whenever a tracked day is changed in Hive, the day is sent to this isolate
/// and stored in a set of modified days.
class TrackedDayChangeIsolate {
  static Isolate? _isolate;
  static SendPort? _sendPort;
  static StreamSubscription<BoxEvent>? _subscription;

  /// Starts watching [box] for changes and spawns the isolate.
  static Future<void> start(Box<TrackedDayDBO> box) async {
    if (_isolate != null) return;
    final readyPort = ReceivePort();
    _isolate = await Isolate.spawn(_entryPoint, readyPort.sendPort);
    _sendPort = await readyPort.first as SendPort;
    _subscription = box.watch().listen((event) {
      final value = event.value;
      if (value is TrackedDayDBO) {
        _sendPort?.send(value.day);
      }
    });
  }

  /// Stops the isolate and cancels the box watcher.
  static Future<void> stop() async {
    await _subscription?.cancel();
    _isolate?.kill(priority: Isolate.immediate);
    _subscription = null;
    _isolate = null;
    _sendPort = null;
  }

  /// Returns the list of modified days collected in the isolate.
  static Future<List<DateTime>> getModifiedDays() async {
    if (_sendPort == null) return <DateTime>[];
    final response = ReceivePort();
    _sendPort!.send(response.sendPort);
    final result = await response.first;
    return (result as List).cast<DateTime>();
  }

  static void _entryPoint(SendPort initSendPort) {
    final port = ReceivePort();
    final modifiedDays = <DateTime>{};
    initSendPort.send(port.sendPort);

    port.listen((message) {
      if (message is DateTime) {
        modifiedDays.add(message);
      } else if (message is SendPort) {
        message.send(modifiedDays.toList());
      }
    });
  }
}
