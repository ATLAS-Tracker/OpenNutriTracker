// auth_safe_sign_out.dart
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:opennutritracker/core/utils/locator.dart';
import 'package:opennutritracker/features/settings/domain/usecase/export_data_supabase_usecase.dart';
import 'package:opennutritracker/features/settings/presentation/bloc/export_import_bloc.dart';
import 'package:opennutritracker/core/utils/navigation_options.dart';

final _log = Logger('AuthSafeSignOut');

Future<void> safeSignOut(BuildContext context) async {
  final supabase = locator<SupabaseClient>();
  final exportUsecase = locator<ExportDataSupabaseUsecase>();
  final userId = supabase.auth.currentUser?.id;

  // Affiche un loader **uniquement** si l’utilisateur est connecté
  if (userId != null && context.mounted) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  try {
    if (userId != null) {
      _log.fine('Export vers Supabase pour uid=$userId');
      final ok = await exportUsecase.exportData(
        ExportImportBloc.exportZipFileName,
        ExportImportBloc.userActivityJsonFileName,
        ExportImportBloc.userIntakeJsonFileName,
        ExportImportBloc.trackedDayJsonFileName,
        ExportImportBloc.userWeightJsonFileName,
      );
      _log.log(ok ? Level.FINE : Level.WARNING,
          ok ? 'Export réussi' : 'Export échoué – on continue quand même');
    } else {
      _log.warning('safeSignOut appelé sans session active');
    }
  } catch (err, stack) {
    _log.severe('Erreur pendant export', err, stack);
  } finally {
    // ▸ 1. Déconnexion Supabase
    try {
      _log.fine('Appel supabase.auth.signOut()');
      await supabase.auth.signOut();
    } catch (err, stack) {
      _log.warning('Erreur pendant signOut', err, stack);
    }

    // ▸ 2. Ferme le loader
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true)
          .popUntil((route) => route.isFirst);
    }

    // ▸ 3. Redirige vers la page login
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed(NavigationOptions.loginRoute);
    }

    _log.fine('safeSignOut terminé → retour login.');
  }
}
