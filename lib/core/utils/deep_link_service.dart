import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uni_links/uni_links.dart';
import 'package:opennutritracker/core/utils/navigation_options.dart';

class DeepLinkService {
  StreamSubscription? _sub;
  final _log = Logger('DeepLinkService');

  Future<void> init(BuildContext context) async {
    final initial = await getInitialUri();
    if (!context.mounted) return;
    if (initial != null) {
      await _handleUri(initial, context);
    }

    _sub = uriLinkStream.listen(
      (uri) {
        if (uri != null && context.mounted) {
          _handleUri(uri, context);
        }
      },
      onError: (err, stack) =>
          _log.warning('Error receiving link', err, stack),
    );
  }

  Future<void> _handleUri(Uri uri, BuildContext context) async {
    if (uri.queryParameters['type'] != 'recovery') return;
    _log.fine('Handling recovery link: $uri');
    try {
      await Supabase.instance.client.auth.getSessionFromUrl(uri);
      if (context.mounted) {
        Navigator.of(context).pushNamed(NavigationOptions.resetPasswordRoute);
      }
    } catch (e, st) {
      _log.warning('Failed to handle link: $e', e, st);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid or expired link')),
        );
      }
    }
  }

  void dispose() {
    _sub?.cancel();
  }
}

