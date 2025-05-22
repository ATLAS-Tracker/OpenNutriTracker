import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:opennutritracker/core/data/data_source/user_weight_dbo.dart';

class UserWeightDataSource {
  final Box<UserWeightDbo> _userWeightBox;

  UserWeightDataSource(this._userWeightBox);

  Future<void> addUserWeight(UserWeightDbo userWeightDbo) async {
    dynamic keyToUpdate;
    /* Iterate over the keys of the box to find a match, find if an entry for the same day already exists */
    for (final key in _userWeightBox.keys) {
      final existingDbo = _userWeightBox.get(key);
      // Check if the DBO exists and is for the same day as the new DBO
      if (existingDbo != null &&
          DateUtils.isSameDay(existingDbo.date, userWeightDbo.date)) {
        keyToUpdate = key; // Store the key of the DBO to be updated
        break; // Found the entry, no need to search further
      }
    }

    if (keyToUpdate != null) {
      await _userWeightBox.put(keyToUpdate, userWeightDbo);
    } else {
      await _userWeightBox.add(userWeightDbo);
    }
  }

  Future<UserWeightDbo?> getUserWeightByDate(DateTime dateTime) async {
    for (final dbo in _userWeightBox.values) {
      if (DateUtils.isSameDay(dbo.date, dateTime)) {
        return dbo;
      }
    }
    return null;
  }
}
