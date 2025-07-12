// auth_safe_sign_out.dart
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:opennutritracker/generated/l10n.dart';

import 'package:opennutritracker/core/utils/locator.dart';
import 'package:opennutritracker/features/settings/domain/usecase/export_data_supabase_usecase.dart';
import 'package:opennutritracker/features/settings/presentation/bloc/export_import_bloc.dart';
import 'package:opennutritracker/core/utils/navigation_options.dart';
import 'package:opennutritracker/core/utils/hive_db_provider.dart';
import 'package:opennutritracker/core/data/repository/config_repository.dart';
import 'package:opennutritracker/features/settings/domain/repository/supabase_exports_repository.dart';

final _log = Logger('AuthSafeSignOut');

Future<void> safeSignOut(BuildContext context) async {
  final supabase = locator<SupabaseClient>();
  final exportUsecase = locator<ExportDataSupabaseUsecase>();
  final configRepo = locator<ConfigRepository>();
  final exportsRepo = locator<SupabaseExportsRepository>();
  final connectivity = locator<Connectivity>();
  final userId = supabase.auth.currentUser?.id;

  // If there is no connection, abort and ask the user to retry later.
  if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).signOutOfflineMessage)),
      );
    }
    return;
  }

  // Affiche un loader **uniquement** si l’utilisateur est connecté
  if (userId != null && context.mounted) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  bool exportFailed = false;
  try {
    if (userId != null) {
      final localDate = await configRepo.getLastDataUpdate();
      DateTime? remoteDate;
      try {
        final file = await exportsRepo.fetchExportFile(
          userId,
          ExportImportBloc.exportZipFileName,
        );
        if (file != null) {
          remoteDate = exportsRepo.fileTimestamp(file);
        }
      } catch (e, stack) {
        _log.warning('Unable to fetch remote timestamp', e, stack);
      }

      final needsUpload = localDate != null &&
          (remoteDate == null || localDate.isAfter(remoteDate));

      if (needsUpload) {
        _log.fine('Export vers Supabase pour uid=$userId');

        Future<bool> doExport() => exportUsecase.exportData(
              ExportImportBloc.exportZipFileName,
              ExportImportBloc.userActivityJsonFileName,
              ExportImportBloc.userIntakeJsonFileName,
              ExportImportBloc.trackedDayJsonFileName,
              ExportImportBloc.userWeightJsonFileName,
            );

        var ok = await doExport();
        if (!ok) {
          _log.warning('Premier export échoué – nouvelle tentative');
          ok = await doExport();
        }
        exportFailed = !ok;
        _log.log(
          ok ? Level.FINE : Level.WARNING,
          ok ? 'Export réussi' : 'Export échoué – on déconnecte quand même',
        );

        if (ok) {
          _log.fine('Export terminé avec succès');
          DateTime? uploadedDate;
          try {
            final uploaded = await exportsRepo.fetchExportFile(
              userId,
              ExportImportBloc.exportZipFileName,
            );
            if (uploaded != null) {
              uploadedDate = exportsRepo.fileTimestamp(uploaded);
            }
          } catch (e, stack) {
            _log.warning('Unable to fetch uploaded timestamp', e, stack);
          }
          if (uploadedDate != null) {
            await configRepo.setLastDataUpdate(uploadedDate.toUtc());
          }
        }
      }
    } else {
      _log.warning('safeSignOut appelé sans session active');
    }
  } catch (err, stack) {
    exportFailed = true;
    _log.severe('Erreur pendant export', err, stack);
  }

  if (exportFailed) {
    if (context.mounted && userId != null) {
      Navigator.of(context, rootNavigator: true)
          .popUntil((route) => route.isFirst);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).signOutSyncFailedMessage)),
      );
    }
    return;
  }

  // ▸ 1. Déconnexion Supabase
  try {
    _log.fine('Appel supabase.auth.signOut()');
    await supabase.auth.signOut();
  } catch (err, stack) {
    _log.warning('Erreur pendant signOut', err, stack);
  }

  final hive = locator<HiveDBProvider>();
  await hive.initForUser(null);
  await registerUserScope(hive);

  // ▸ 2. Ferme le loader
  if (context.mounted && userId != null) {
    Navigator.of(context, rootNavigator: true)
        .popUntil((route) => route.isFirst);
  }

  // ▸ 3. Redirige vers la page login
  if (context.mounted) {
    Navigator.of(context).pushReplacementNamed(NavigationOptions.loginRoute);
  }

  _log.fine('safeSignOut terminé → retour login.');
}
