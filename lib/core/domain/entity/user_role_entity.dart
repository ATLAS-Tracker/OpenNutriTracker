import 'package:flutter/material.dart';

enum UserRoleEntity {
  coach,
  student,
  unspecified,
}

extension UserRoleEntityExtension on UserRoleEntity {
  String getName(BuildContext context) {
    // This is a placeholder for localization.
    // In a real app, you would use a localization library like intl.
    switch (this) {
      case UserRoleEntity.coach:
        return 'Coach';
      case UserRoleEntity.student:
        return 'Student';
      case UserRoleEntity.unspecified:
        return 'Unspecified';
    }
  }
}
