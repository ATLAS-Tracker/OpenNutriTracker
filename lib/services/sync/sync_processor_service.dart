import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:opennutritracker/services/sync/sync_action.dart';

class SyncProcessorService {
  final Box<SyncAction> _queueBox;
  final SupabaseClient _client;
  final Connectivity _connectivity;

  StreamSubscription<ConnectivityResult>? _sub;
  bool _processing = false;

  SyncProcessorService(this._queueBox, this._client, this._connectivity);

  Future<void> start() async {
    _sub = _connectivity.onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        processQueue();
      }
    });
    final current = await _connectivity.checkConnectivity();
    if (current != ConnectivityResult.none) {
      processQueue();
    }
  }

  Future<void> dispose() async {
    await _sub?.cancel();
  }

  Future<void> processQueue() async {
    if (_processing) return;
    _processing = true;
    try {
      final keys = _queueBox.keys.toList();
      for (final key in keys) {
        final conn = await _connectivity.checkConnectivity();
        if (conn == ConnectivityResult.none) break;
        final action = _queueBox.get(key);
        if (action == null) continue;
        final success = await _performAction(action);
        if (success) {
          await _queueBox.delete(key);
        } else {
          action.attempts += 1;
          if (action.attempts >= 3) {
            await _queueBox.delete(key);
          } else {
            await _queueBox.put(key, action);
          }
        }
      }
    } finally {
      _processing = false;
    }
  }

  Future<bool> _performAction(SyncAction action) async {
    try {
      final table = _client.from(action.table);
      switch (action.action) {
        case 'create':
          await table.insert(action.data!);
          break;
        case 'update':
          await table.update(action.data!).eq('id', action.id);
          break;
        case 'delete':
          await table.delete().eq('id', action.id);
          break;
        default:
          return true;
      }
      return true;
    } catch (_) {
      return false;
    }
  }
}
