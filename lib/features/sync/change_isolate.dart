import 'dart:isolate';
import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';

/// Generic isolate watcher that collects items of type [T] whenever a Hive
/// box emits an event that can be converted to a [T].
class _RemoveCommand {
  final List<dynamic> items;
  const _RemoveCommand(this.items);
}

/// Generic isolate watcher that collects items of type [T] whenever a Hive
/// box emits an event that can be converted to a [T].
class ChangeIsolate<T> {
  final Box box;
  final T? Function(BoxEvent event) extractor;

  Isolate? _isolate;
  SendPort? _sendPort;
  StreamSubscription<BoxEvent>? _subscription;

  ChangeIsolate({required this.box, required this.extractor});

  /// Starts watching the box and spawns the isolate if not already running.
  Future<void> start() async {
    if (_isolate != null) return;
    final readyPort = ReceivePort();
    _isolate = await Isolate.spawn(_entryPoint, readyPort.sendPort);
    _sendPort = await readyPort.first as SendPort;
    _subscription = box.watch().listen((event) {
      final msg = extractor(event);
      if (msg != null) {
        _sendPort?.send(msg);
      }
    });
  }

  /// Stops the isolate and cancels the box watcher.
  Future<void> stop() async {
    await _subscription?.cancel();
    _isolate?.kill(priority: Isolate.immediate);
    _subscription = null;
    _isolate = null;
    _sendPort = null;
  }

  /// Returns the list of collected items.
  Future<List<T>> getItems() async {
    if (_sendPort == null) return <T>[];
    final response = ReceivePort();
    _sendPort!.send(response.sendPort);
    final result = await response.first;
    return (result as List).cast<T>();
  }

  /// Removes [items] from the internal modified set.
  Future<void> removeItems(List<T> items) async {
    if (_sendPort == null || items.isEmpty) return;
    _sendPort!.send(_RemoveCommand(items));
  }

  static void _entryPoint(SendPort initSendPort) {
    final port = ReceivePort();
    final modified = <dynamic>{};
    initSendPort.send(port.sendPort);

    port.listen((message) {
      if (message is SendPort) {
        message.send(modified.toList());
      } else if (message is _RemoveCommand) {
        modified.removeAll(message.items);
      } else {
        modified.add(message);
      }
    });
  }
}
