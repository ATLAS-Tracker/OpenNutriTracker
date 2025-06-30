import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:opennutritracker/core/utils/navigation_options.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  bool _loading = false;
  final supabase = Supabase.instance.client;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    final email = _emailCtrl.text.trim();

    try {
      await supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: 'atlas-tracker://login-callback',
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'E-mail envoyé ! Clique sur le lien depuis ton appareil pour choisir un nouveau mot de passe.',
          ),
        ),
      );

      // 👉 no more push to ResetPasswordScreen here
      Navigator.of(context).pop(); // or pushNamed(loginRoute)
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de l\'envoi de l\'e-mail : $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot your password?')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: 'Enter your email',
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'E-mail required' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _loading ? null : _sendResetEmail,
                  child: _loading
                      ? const CircularProgressIndicator()
                      : const Text('Send password reset email'),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamedAndRemoveUntil(
                    NavigationOptions.loginRoute, // your login route
                    (route) => false, // remove everything else from the stack
                  ),
                  child: const Text('Back to sign in'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
