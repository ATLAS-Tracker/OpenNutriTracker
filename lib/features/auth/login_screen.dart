import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:opennutritracker/core/utils/navigation_options.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _navigateHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(NavigationOptions.mainRoute);
  }

  void _showError(BuildContext context, Object error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$error')),
    );
    Logger('LoginScreen').warning('Auth error', error);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SupaEmailAuth(
              redirectTo: kIsWeb ? null : 'io.supabase.flutter://login-callback/',
              onSignInComplete: (_) => _navigateHome(context),
              onSignUpComplete: (_) => _navigateHome(context),
              onPasswordResetEmailSent: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password reset email sent')),
                );
              },
              onError: (error) => _showError(context, error),
            ),
            const SizedBox(height: 32),
            SupaMagicAuth(
              redirectUrl: kIsWeb ? null : 'io.supabase.flutter://login-callback/',
              onSuccess: (_) => _navigateHome(context),
              onError: (error) => _showError(context, error),
            ),
            const SizedBox(height: 32),
            SupaSocialsAuth(
              colored: true,
              socialProviders: const [OAuthProvider.google, OAuthProvider.apple],
              redirectUrl: kIsWeb ? null : 'io.supabase.flutter://login-callback/',
              onSuccess: (_) => _navigateHome(context),
              onError: (error) => _showError(context, error),
            ),
          ],
        ),
      ),
    );
  }
}
