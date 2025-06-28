import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:email_validator/email_validator.dart';
import 'package:opennutritracker/core/utils/navigation_options.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> _sendResetEmail(BuildContext context) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final email = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Forgot password'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) =>
                value != null && EmailValidator.validate(value)
                    ? null
                    : 'Enter valid email',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context, controller.text.trim());
              }
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );

    if (email != null) {
      try {
        await Supabase.instance.client.auth.resetPasswordForEmail(
          email,
          redirectTo: 'com.opennutritracker://reset-callback',
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Check your email for reset link')),
          );
        }
      } catch (error, st) {
        Logger('LoginScreen').warning('Reset email failed', error, st);
        if (context.mounted) _showError(context, error);
      }
    }
  }

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
              redirectTo:
                  kIsWeb ? null : 'io.supabase.flutter://login-callback/',
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
              redirectUrl:
                  kIsWeb ? null : 'io.supabase.flutter://login-callback/',
              onSuccess: (_) => _navigateHome(context),
              onError: (error) => _showError(context, error),
            ),
            const SizedBox(height: 32),
            SupaSocialsAuth(
              colored: true,
              socialProviders: const [
                OAuthProvider.google,
                OAuthProvider.apple
              ],
              redirectUrl:
                  kIsWeb ? null : 'io.supabase.flutter://login-callback/',
              onSuccess: (_) => _navigateHome(context),
              onError: (error) => _showError(context, error),
            ),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () => _sendResetEmail(context),
              child: const Text('Forgot password?'),
            ),
          ],
        ),
      ),
    );
  }
}
