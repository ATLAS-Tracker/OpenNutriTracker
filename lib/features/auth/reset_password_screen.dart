import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:opennutritracker/core/utils/navigation_options.dart';
import 'package:opennutritracker/features/auth/validate_password.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _loading = false;
  final supabase = Supabase.instance.client;

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    final newPass = _passwordCtrl.text.trim();

    try {
      await supabase.auth.updateUser(UserAttributes(password: newPass));

      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Mot de passe changé !'),
          content: const Text(
            'Tu peux maintenant te connecter avec ton nouveau mot de passe.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      Navigator.of(context).pushNamedAndRemoveUntil(
        NavigationOptions.mainRoute,
        (_) => false,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  InputDecoration _decoration(String hint, IconData icon) => InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nouveau mot de passe')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            Text('Créer un nouveau mot de passe',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Text(
              'Entre un nouveau mot de passe sécurisé.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),

            // --- New password --- //
            TextFormField(
              controller: _passwordCtrl,
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration:
                  _decoration('Nouveau mot de passe', Icons.lock_outline),

              // • Ici on veut la vérification complète, donc isSignIn = false (valeur par défaut)
              validator: validatePassword,
            ),
            const SizedBox(height: 16),

            // --- Confirm --- //
            TextFormField(
              controller: _confirmCtrl,
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration:
                  _decoration('Confirmer le mot de passe', Icons.lock_outline),
              validator: (v) => (v != _passwordCtrl.text)
                  ? 'Les mots de passe ne correspondent pas'
                  : null,
            ),
            const SizedBox(height: 32),

            // --- Button --- //
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _loading ? null : _resetPassword,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text('Changer le mot de passe'),
              ),
            ),
            const SizedBox(height: 32),

            // --- Tips --- //
            Text(
              '• Utilise au moins 8 caractères\n'
              '• Mélange chiffres & caractères spéciaux\n'
              '• Majuscules + minuscules',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ]),
        ),
      ),
    );
  }
}
