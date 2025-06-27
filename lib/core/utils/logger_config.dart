import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class LoggerConfig {
  static bool _initialized = false;

  static void intiLogger() {
    if (_initialized) return;
    _initialized = true;
    Logger.root
      ..level = Level.ALL
      ..clearListeners();
    Logger.root.onRecord.listen((record) {
      debugPrint('${record.level.name}: ${record.loggerName}: ${record.message}');
    });
  }
}
