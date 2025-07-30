import 'package:flutter/material.dart';
import 'package:opennutritracker/core/utils/locator.dart';
import 'package:opennutritracker/core/domain/usecase/add_config_usecase.dart';
import 'package:opennutritracker/generated/l10n.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:opennutritracker/features/auth/auth_safe_sign_out.dart';
import 'package:opennutritracker/core/data/repository/config_repository.dart';

class ManageAccountDialog extends StatefulWidget {
  const ManageAccountDialog({super.key});

  @override
  State<ManageAccountDialog> createState() => _ManageAccountDialogState();
}

class _ManageAccountDialogState extends State<ManageAccountDialog> {
  bool _syncEnabled = true;
  final _addConfig = locator<AddConfigUsecase>();
  final _configRepo = locator<ConfigRepository>();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final enabled = await _configRepo.getSupabaseSyncEnabled();
    setState(() => _syncEnabled = enabled);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Manage account'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We only collect data essential to the proper functioning of the app:\n\n'
              'Email address: used for login and account identification.\n\n'
              'Nutrition data: your daily weight, calories, protein, fat, and carbohydrate intake.\n\n'
              'Goals: your personalized targets for calories, protein, fat, and carbs.\n\n'
              'All data is securely stored on Supabase. We do not share any of your data with third parties.',
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Enable Supabase Sync'),
              value: _syncEnabled,
              onChanged: (value) {
                setState(() => _syncEnabled = value);
                _addConfig.setSupabaseSyncEnabled(value);
              },
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => _confirmDelete(context),
              child: const Text('Delete My Account'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(S.of(context).dialogOKLabel),
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(S.of(context).dialogCancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Confirm Deletion'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await _deleteAccount();
    }
  }

  Future<void> _deleteAccount() async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;
    try {
      if (userId != null) {
        await supabase.rpc('delete_user', params: {'uid': userId});
      }
    } catch (_) {}
    if (mounted) {
      await safeSignOut(context);
    }
  }
}
