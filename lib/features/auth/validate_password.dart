String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Mot de passe requis';
  }
  if (value.length < 8) {
    return 'Au moins 8 caractères';
  }
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Au moins 1 majuscule';
  }
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return 'Au moins 1 minuscule';
  }
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'Au moins 1 chiffre';
  }
  if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return 'Au moins 1 caractère spécial';
  }
  return null;
}
