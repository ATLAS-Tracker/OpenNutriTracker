import 'dart:async';

import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uni_links/uni_links.dart';

import '../../core/utils/app_navigator.dart';
import '../../core/utils/navigation_options.dart';

class AuthLinkHandler {
  StreamSubscription? _sub;
  final _log = Logger('AuthLinkHandler');

  Future<void> initialize() async {
    // Handle cold start link
    try {
      final uri = await getInitialUri();
      await _handleUri(uri);
    } catch (e, st) {
      _log.warning('Failed to read initial uri', e, st);
    }

    _sub = uriLinkStream.listen((uri) {
      _handleUri(uri);
    }, onError: (err, st) {
      _log.warning('Deep link error', err as Object, st);
    });
  }

  Future<void> _handleUri(Uri? uri) async {
    if (uri == null) return;
    _log.fine('Received uri: $uri');
    try {
      final hasRecovery = uri.toString().contains('type=recovery');
      await Supabase.instance.client.auth.getSessionFromUrl(uri);
      if (hasRecovery) {
        rootNavigatorKey.currentState
            ?.pushReplacementNamed(NavigationOptions.resetPasswordRoute);
      } else {
        rootNavigatorKey.currentState
            ?.pushReplacementNamed(NavigationOptions.mainRoute);
      }
    } catch (e, st) {
      _log.warning('Error handling auth link', e, st);
    }
  }

  Future<void> dispose() async {
    await _sub?.cancel();
  }
}
