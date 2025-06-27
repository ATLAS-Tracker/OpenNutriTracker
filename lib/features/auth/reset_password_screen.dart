import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:opennutritracker/core/utils/navigation_options.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  void _navigateHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(NavigationOptions.mainRoute);
  }

  void _showError(BuildContext context, Object error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$error')),
    );
    Logger('ResetPassword').warning('Password reset error', error);
  }

  @override
  Widget build(BuildContext context) {
    final accessToken = Supabase.instance.client.auth.currentSession?.accessToken;
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SupaResetPassword(
            accessToken: accessToken,
            onSuccess: (_) => _navigateHome(context),
            onError: (error) => _showError(context, error),
          ),
        ),
      ),
    );
  }
}
