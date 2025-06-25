import 'dart:async';
import 'dart:isolate';

import 'package:hive_flutter/hive_flutter.dart';

/// Commande interne : retirer un ensemble d’items du set `modified`.
class _RemoveCommand {
  final List<dynamic> items;
  const _RemoveCommand(this.items);
}

/// Isolat générique qui collecte des objets de type [T] émis par une box Hive.
class ChangeIsolate<T> {
  final Box box;
  final T? Function(BoxEvent event) extractor;

  /// Callback optionnel appelé **après chaque ajout** dans le set.
  /// Il n’est plus `final`, on peut donc l’injecter dynamiquement.
  void Function()? onItemCollected;

  Isolate? _isolate;
  SendPort? _sendPort;
  StreamSubscription<BoxEvent>? _subscription;

  ChangeIsolate({
    required this.box,
    required this.extractor,
    this.onItemCollected,
  });

  /* ---------- cycle de vie ---------- */

  Future<void> start() async {
    if (_isolate != null) return; // déjà démarré

    // 1) On démarre l’isolat « collecteur »
    final readyPort = ReceivePort();
    _isolate = await Isolate.spawn(_entryPoint, readyPort.sendPort);
    _sendPort = await readyPort.first as SendPort;

    // 2) On écoute les changements de la box Hive
    _subscription = box.watch().listen((event) {
      final msg = extractor(event);
      if (msg != null) {
        _sendPort?.send(msg); // envoie vers l’isolat secondaire
        onItemCollected?.call(); // déclencheur facultatif
      }
    });
  }

  Future<void> stop() async {
    await _subscription?.cancel();
    _isolate?.kill(priority: Isolate.immediate);
    _subscription = null;
    _isolate = null;
    _sendPort = null;
  }

  /* ---------- API publique ---------- */

  Future<List<T>> getItems() async {
    if (_sendPort == null) return <T>[];
    final response = ReceivePort();
    _sendPort!.send(response.sendPort);
    final result = await response.first;
    return (result as List).cast<T>();
  }

  Future<void> removeItems(List<T> items) async {
    if (_sendPort == null || items.isEmpty) return;
    _sendPort!.send(_RemoveCommand(items));
  }

  /* ---------- isolat secondaire ---------- */

  static void _entryPoint(SendPort initSendPort) {
    final port = ReceivePort();
    final modified = <dynamic>{};
    initSendPort.send(port.sendPort); // renvoie le SendPort au parent

    port.listen((message) {
      if (message is SendPort) {
        message.send(modified.toList()); // getItems()
      } else if (message is _RemoveCommand) {
        modified.removeAll(message.items); // removeItems()
      } else {
        modified.add(message); // ajout d’un nouvel item
      }
    });
  }
}
