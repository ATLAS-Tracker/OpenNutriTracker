import 'package:flutter/material.dart';
import 'package:opennutritracker/generated/l10n.dart';

String? validatePassword(BuildContext context, String? value) {
  if (value == null || value.isEmpty) {
    return S.of(context).passwordRequired;
  }
  if (value.length < 8) {
    return S.of(context).passwordMinLength;
  }
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return S.of(context).passwordUppercase;
  }
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return S.of(context).passwordLowercase;
  }
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return S.of(context).passwordDigit;
  }
  if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return S.of(context).passwordSpecialChar;
  }
  return null;
}
