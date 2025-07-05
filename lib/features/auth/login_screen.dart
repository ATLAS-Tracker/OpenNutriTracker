import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:opennutritracker/core/utils/navigation_options.dart';
import 'package:app_links/app_links.dart';
import 'package:email_validator/email_validator.dart';
import 'package:opennutritracker/features/auth/validate_password.dart';
import 'package:opennutritracker/generated/l10n.dart';
import 'forgot_password_screen.dart';
import 'reset_password_screen.dart';
import 'package:opennutritracker/core/utils/locator.dart';
import 'package:opennutritracker/core/utils/hive_db_provider.dart';
import 'package:opennutritracker/core/utils/secure_app_storage_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool _obscurePassword = true;

  bool _loading = false;
  final supabase = Supabase.instance.client;

  /// Navigate to the home screen after a successful sign‑in.
  void _navigateHome() =>
      Navigator.of(context).pushReplacementNamed(NavigationOptions.mainRoute);

  /// Display an error message and log it.
  void _showError(Object error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$error')));
    Logger('LoginScreen').warning('Auth error', error);
  }

  /// Configure deep‑link handling (password‑reset flow).
  void _configDeepLink() {
    final links = AppLinks();

    links.uriLinkStream.listen((Uri? uri) async {
      if (uri == null || uri.host != 'login-callback') return;

      try {
        await supabase.auth.getSessionFromUrl(uri);
        if (!mounted) return;
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
        );
      } catch (e) {
        debugPrint('Deep‑link error: $e');
      }
    });
  }

  /// Attempt to authenticate with e‑mail / password.
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final email = _emailCtrl.text.trim();
    final pass = _passwordCtrl.text.trim();

    // Capture everything that needs context before the async gap
    final l10n = S.of(context);

    try {
      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: pass,
      );

      if (res.session != null && mounted) {
        final hive = locator<HiveDBProvider>();
        final secure = SecureAppStorageProvider();
        await hive.initHiveDB(
          await secure.getHiveEncryptionKey(),
          userId: res.user?.id,
        );
        _navigateHome();
      }
    } on AuthException catch (e) {
      final message = e.message.toLowerCase();

      if (!mounted) return; // context might be gone

      if (message.contains('error granting user')) {
        _showError(l10n.loginAlreadySignedIn);
      } else {
        _showError(e.message);
      }
    } catch (e) {
      if (mounted) _showError(e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _configDeepLink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).loginTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                labelText: S.of(context).loginEmailLabel,
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? S.of(context).loginEmailRequired
                  : (EmailValidator.validate(v.trim())
                      ? null
                      : S.of(context).loginEmailInvalid),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordCtrl,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                labelText: S.of(context).loginPasswordLabel,
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              validator: (value) => validatePassword(context, value),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor:
                      Theme.of(context).colorScheme.onPrimaryContainer,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                onPressed: _loading ? null : _submit,
                child: _loading
                    ? const CircularProgressIndicator()
                    : Text(S.of(context).loginButton),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
              ),
              child: Text(S.of(context).loginForgotPassword),
            ),
          ]),
        ),
      ),
    );
  }
}
