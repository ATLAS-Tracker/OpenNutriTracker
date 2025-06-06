import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';
import 'package:opennutritracker/core/data/repository/sql_queue_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SqlQueueConsumer {
  final SqlQueueRepository _repository;
  final SupabaseClient _supabaseClient;
  final log = Logger('SqlQueueConsumer');

  StreamSubscription<ConnectivityResult>? _subscription;

  SqlQueueConsumer(this._repository, this._supabaseClient);

  void start() {
    _subscription =
        Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        _processQueue();
      }
    });
  }

  Future<void> _processQueue() async {
    while (_repository.length > 0) {
      final command = await _repository.peek();
      if (command == null) {
        break;
      }
      try {
        await _executeSql(command.command);
        await _repository.removeFirst();
      } catch (e) {
        command.retryCount += 1;
        if (command.retryCount >= 3) {
          log.severe('SQL command failed after 3 retries: ${command.command}');
          await _repository.removeFirst();
        } else {
          await _repository.updateFirst(command);
        }
        break;
      }
    }
  }

  Future<void> _executeSql(String sql) async {
    await _supabaseClient.rpc('execute_sql', params: {'sql': sql});
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
  }
}
