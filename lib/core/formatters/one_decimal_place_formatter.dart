import 'package:flutter/services.dart';

class OneDecimalPlaceFormatter extends TextInputFormatter {
  // Regex to allow numbers with at most one decimal place (dot or comma).
  // Allows an empty string, whole numbers, numbers followed by a dot/comma,
  // or numbers followed by a dot/comma and a single digit.
  final RegExp _regExp = RegExp(r'^\d*([.,]\d?)?$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // If the new value is empty (e.g., user erases everything), accept it.
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // If the new value matches our regex (is valid).
    if (_regExp.hasMatch(newValue.text)) {
      return newValue;
    }
    // If the new value does not match (is invalid).
    // Return the old value, which should "block" the invalid input.
    return oldValue;
  }
}
