import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:opennutritracker/core/data/data_source/user_activity_dbo.dart';
import 'package:opennutritracker/core/data/data_source/user_weight_dbo.dart';
import 'package:opennutritracker/core/data/dbo/app_theme_dbo.dart';
import 'package:opennutritracker/core/data/dbo/config_dbo.dart';
import 'package:opennutritracker/core/data/dbo/intake_dbo.dart';
import 'package:opennutritracker/core/data/dbo/recipe_dbo.dart';
import 'package:opennutritracker/core/data/dbo/intake_recipe_dbo.dart';
import 'package:opennutritracker/core/data/dbo/intake_type_dbo.dart';
import 'package:opennutritracker/core/data/dbo/meal_or_recipe_dbo.dart';
import 'package:opennutritracker/core/data/dbo/physical_activity_dbo.dart';
import 'package:opennutritracker/core/data/dbo/meal_dbo.dart';
import 'package:opennutritracker/core/data/dbo/meal_nutriments_dbo.dart';
import 'package:opennutritracker/core/data/dbo/tracked_day_dbo.dart';
import 'package:opennutritracker/core/data/dbo/user_dbo.dart';
import 'package:opennutritracker/core/data/dbo/user_gender_dbo.dart';
import 'package:opennutritracker/core/data/dbo/user_pal_dbo.dart';
import 'package:opennutritracker/core/data/dbo/user_weight_goal_dbo.dart';
import 'package:opennutritracker/features/sync/tracked_day_change_isolate.dart';
import 'package:opennutritracker/core/utils/secure_app_storage_provider.dart';

class HiveDBProvider extends ChangeNotifier {
  static const configBoxName = 'ConfigBox';
  static const intakeBoxName = 'IntakeBox';
  static const userActivityBoxName = 'UserActivityBox';
  static const userBoxName = 'UserBox';
  static const trackedDayBoxName = 'TrackedDayBox';
  static const recipeBoxName = "RecipeBox";
  static const userWeightBoxName = 'UserWeightBox';

  String? _userId;
  String _boxName(String base) => _userId == null ? base : '${_userId}_$base';

  late Box<ConfigDBO> configBox;
  late Box<IntakeDBO> intakeBox;
  late Box<UserActivityDBO> userActivityBox;
  late Box<UserDBO> userBox;
  late Box<TrackedDayDBO> trackedDayBox;
  late Box<RecipesDBO> recipeBox;
  late TrackedDayChangeIsolate trackedDayWatcher;
  late Box<UserWeightDbo> userWeightBox;

  static bool _adaptersRegistered = false;

  Future<void> initHiveDB(Uint8List encryptionKey, {String? userId}) async {
    final encryptionCypher = HiveAesCipher(encryptionKey);

    // Close previously opened boxes and watcher if any
    if (Hive.isBoxOpen(_boxName(configBoxName))) {
      // trackedDayWatcher must be stopped before its box is closed
      await trackedDayWatcher.stop();

      // To prevent resource leaks, any new box added to this provider must also be added here.
      await Future.wait([
        configBox.close(),
        intakeBox.close(),
        recipeBox.close(),
        userActivityBox.close(),
        userBox.close(),
        trackedDayBox.close(),
        userWeightBox.close(),
      ]);
    }

    _userId = userId;

    await Hive.initFlutter();
    if (!_adaptersRegistered) {
      Hive.registerAdapter(ConfigDBOAdapter());
      Hive.registerAdapter(IntakeDBOAdapter());
      Hive.registerAdapter(MealDBOAdapter());
      Hive.registerAdapter(IntakeForRecipeDBOAdapter());

      Hive.registerAdapter(MealOrRecipeDBOAdapter());

      Hive.registerAdapter(MealNutrimentsDBOAdapter());
      Hive.registerAdapter(MealSourceDBOAdapter());
      Hive.registerAdapter(IntakeTypeDBOAdapter());
      Hive.registerAdapter(RecipesDBOAdapter());
      Hive.registerAdapter(UserDBOAdapter());
      Hive.registerAdapter(UserGenderDBOAdapter());
      Hive.registerAdapter(UserWeightGoalDBOAdapter());
      Hive.registerAdapter(UserPALDBOAdapter());
      Hive.registerAdapter(TrackedDayDBOAdapter());
      Hive.registerAdapter(UserActivityDBOAdapter());
      Hive.registerAdapter(PhysicalActivityDBOAdapter());
      Hive.registerAdapter(PhysicalActivityTypeDBOAdapter());
      Hive.registerAdapter(AppThemeDBOAdapter());
      Hive.registerAdapter(UserWeightDboAdapter());
      _adaptersRegistered = true;
    }

    configBox =
        await Hive.openBox(_boxName(configBoxName), encryptionCipher: encryptionCypher);
    intakeBox =
        await Hive.openBox(_boxName(intakeBoxName), encryptionCipher: encryptionCypher);
    recipeBox =
        await Hive.openBox(_boxName(recipeBoxName), encryptionCipher: encryptionCypher);
    userActivityBox = await Hive.openBox(_boxName(userActivityBoxName),
        encryptionCipher: encryptionCypher);
    userBox =
        await Hive.openBox(_boxName(userBoxName), encryptionCipher: encryptionCypher);
    trackedDayBox = await Hive.openBox(_boxName(trackedDayBoxName),
        encryptionCipher: encryptionCypher);
    trackedDayWatcher = TrackedDayChangeIsolate(trackedDayBox);
    await trackedDayWatcher.start();
    userWeightBox = await Hive.openBox(
      _boxName(userWeightBoxName),
      encryptionCipher: encryptionCypher,
    );
  }

  static generateNewHiveEncryptionKey() => Hive.generateSecureKey();

  /// Helper to (re)initialize Hive for the provided [userId].
  /// This fetches the encryption key from secure storage and delegates
  /// to [initHiveDB].
  Future<void> initForUser(String? userId) async {
    final secure = SecureAppStorageProvider();
    await initHiveDB(await secure.getHiveEncryptionKey(), userId: userId);
  }

  @override
  void dispose() {
    trackedDayWatcher.stop();
    super.dispose();
  }
}
