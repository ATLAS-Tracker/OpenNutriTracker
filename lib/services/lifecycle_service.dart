import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:opennutritracker/services/firebase_messaging_service.dart';

/// Observes the application lifecycle to refresh macro goals when returning
/// to the foreground or on cold start.
class LifecycleService with WidgetsBindingObserver {
  LifecycleService._internal();
  static final LifecycleService _instance = LifecycleService._internal();
  factory LifecycleService.instance() => _instance;

  final Logger _log = Logger('LifecycleService');

  /// Initializes the service and performs an initial refresh if needed.
  Future<void> init() async {
    WidgetsBinding.instance.addObserver(this);
    _log.fine('[🚀] LifecycleService initialized');
    await FirebaseMessagingService.instance().refreshMacroGoalsIfStudent();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _log.fine('[🔄] App resumed, refreshing macro goals');
      FirebaseMessagingService.instance().refreshMacroGoalsIfStudent();
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
