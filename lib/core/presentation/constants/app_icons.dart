import 'package:flutter/material.dart';

class AppIcons {
  AppIcons._(); // This class is not meant to be instantiated.
  static const IconData iconUp = Icons.keyboard_arrow_up; /* ^ */
  static const IconData iconDown = Icons.keyboard_arrow_down; /* ˅ */
  static const IconData iconFlat = Icons.remove; /* - */

  static IconData getIconForDifference(
      double currentValue, double referenceValue,
      {double precision = 0.1}) {
    final double difference = currentValue - referenceValue;

    if (difference > precision) {
      return AppIcons.iconUp;
    } else if (difference < -precision) {
      return AppIcons.iconDown;
    }
    return AppIcons.iconFlat;
  }
}
