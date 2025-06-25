import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:opennutritracker/core/data/dbo/tracked_day_dbo.dart';
import 'package:opennutritracker/core/utils/extensions.dart'; // toParsedDay()
import 'package:opennutritracker/features/sync/change_isolate.dart';
import 'package:opennutritracker/features/sync/supabase_client.dart';

/// Surveille une box de [TrackedDayDBO] et synchronise les journées modifiées
/// avec Supabase dès qu’une connexion est disponible.
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
            if (value is TrackedDayDBO) return value.day;
            return null;
          },
          onItemCollected: null, // sera fixé dans initState ci-dessous
        ) {
    // Le callback doit être ajouté dans le corps, car `this` n'est
    // pas encore disponible dans l'initialisation de super().
    super.onItemCollected?.call(); // no-op ici
  }

  /// Proxy pratique pour récupérer les jours en attente.
  Future<List<DateTime>> getModifiedDays() => getItems();

  /* ---------- Cycle de vie ---------- */

  Future<void> start() async {
    print("[TrackedDayChangeIsolate] Starting isolate");
    // 1️⃣  On branche le callback AVANT d'initialiser l'écoute de la box
    onItemCollected ??= _attemptSync;

    // 2️⃣  Puis on démarre l'isolat + le watcher
    await super.start();

    // 3️⃣  Tentative immédiate (au cas où des jours étaient déjà en attente)
    await _attemptSync();

    // 4️⃣  Réécoute les changements de connectivité
    _connectivitySub =
        _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
  }

  @override
  Future<void> stop() async {
    await _connectivitySub?.cancel();
    _connectivitySub = null;
    await super.stop();
  }

  /* ---------- Gestion de la connexion ---------- */

  void _onConnectivityChanged(ConnectivityResult result) {
    if (result != ConnectivityResult.none) {
      _attemptSync();
    }
  }

  /* ---------- Synchro Supabase ---------- */

  Future<void> _attemptSync() async {
    print('[TrackedDayChangeIsolate] Attempting sync');

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

        // Convertit chaque jour en JSON
        for (final day in batch) {
          final dbo = box.get(day.toParsedDay()) as TrackedDayDBO?;
          if (dbo != null) entries.add(dbo.toJson());
        }

        // Si on a quelque chose à envoyer…
        if (entries.isNotEmpty) {
          // Double-vérifie qu’on est toujours en ligne
          if (await _connectivity.checkConnectivity() ==
              ConnectivityResult.none) {
            break; // on réessaiera plus tard, sans supprimer
          }

          await _service.upsertTrackedDays(entries);
          await removeItems(batch); // ← on ne retire qu’après succès
        }
      }
    } finally {
      _syncing = false;
    }
  }
}
