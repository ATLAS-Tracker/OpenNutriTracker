// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(versionNumber) => "Version ${versionNumber}";

  static String m1(pctCarbs, pctFats, pctProteins) =>
      "${pctCarbs}% carbs, ${pctFats}% fats, ${pctProteins}% proteins";

  static String m2(riskValue) => "Risk of comorbidities: ${riskValue}";

  static String m3(age) => "${age} years";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "activityExample": MessageLookupByLibrary.simpleMessage(
            "e.g. running, biking, yoga ..."),
        "activityLabel": MessageLookupByLibrary.simpleMessage("Activity"),
        "addItemLabel": MessageLookupByLibrary.simpleMessage("Add new Item:"),
        "addLabel": MessageLookupByLibrary.simpleMessage("Add"),
        "additionalInfoLabelCompendium2011": MessageLookupByLibrary.simpleMessage(
            "Information provided\n by the \n\'2011 Compendium\n of Physical Activities\'"),
        "additionalInfoLabelCustom":
            MessageLookupByLibrary.simpleMessage("Custom Meal Item"),
        "additionalInfoLabelFDC": MessageLookupByLibrary.simpleMessage(
            "More Information at\nFoodData Central"),
        "additionalInfoLabelOFF": MessageLookupByLibrary.simpleMessage(
            "More Information at\nOpenFoodFacts"),
        "additionalInfoLabelUnknown":
            MessageLookupByLibrary.simpleMessage("Unknown Meal Item"),
        "ageLabel": MessageLookupByLibrary.simpleMessage("Age"),
        "allItemsLabel": MessageLookupByLibrary.simpleMessage("All"),
        "alphaVersionName": MessageLookupByLibrary.simpleMessage("[Alpha]"),
        "appDescription": MessageLookupByLibrary.simpleMessage(
            "AtlasTracker is a free and open-source calorie and nutrient tracker that respects your privacy."),
        "appLicenseLabel":
            MessageLookupByLibrary.simpleMessage("GPL-3.0 license"),
        "appTitle": MessageLookupByLibrary.simpleMessage("AtlasTracker"),
        "appVersionName": m0,
        "averageWeightBody": MessageLookupByLibrary.simpleMessage(
            "Average user weight over the last seven days. The current day is not counted."),
        "averageWeightLabel":
            MessageLookupByLibrary.simpleMessage("Average Weight"),
        "baseQuantityLabel":
            MessageLookupByLibrary.simpleMessage("Base quantity (g/ml)"),
        "betaVersionName": MessageLookupByLibrary.simpleMessage("[Beta]"),
        "bmiInfo": MessageLookupByLibrary.simpleMessage(
            "Body Mass Index (BMI) is a index to classify overweight and obesity in adults. It is defined as weight in kilograms divided by the square of height in meters (kg/m²).\n\nBMI does not differentiate between fat and muscle mass and can be misleading for some individuals."),
        "bmiLabel": MessageLookupByLibrary.simpleMessage("BMI"),
        "breakfastExample": MessageLookupByLibrary.simpleMessage(
            "e.g. cereal, milk, coffee ..."),
        "breakfastLabel": MessageLookupByLibrary.simpleMessage("Breakfast"),
        "burnedLabel": MessageLookupByLibrary.simpleMessage("burned"),
        "buttonNextLabel": MessageLookupByLibrary.simpleMessage("NEXT"),
        "buttonResetLabel": MessageLookupByLibrary.simpleMessage("Reset"),
        "buttonSaveLabel": MessageLookupByLibrary.simpleMessage("Save"),
        "buttonStartLabel": MessageLookupByLibrary.simpleMessage("START"),
        "buttonYesLabel": MessageLookupByLibrary.simpleMessage("YES"),
        "calculationsMacronutrientsDistributionLabel":
            MessageLookupByLibrary.simpleMessage("Macros distribution"),
        "calculationsMacrosDistribution": m1,
        "calculationsRecommendedLabel":
            MessageLookupByLibrary.simpleMessage("(recommended)"),
        "calculationsTDEEIOM2006Label": MessageLookupByLibrary.simpleMessage(
            "Institute of Medicine Equation"),
        "calculationsTDEELabel":
            MessageLookupByLibrary.simpleMessage("TDEE equation"),
        "caloriesLabel": MessageLookupByLibrary.simpleMessage("Calories"),
        "carbohydrateLabel":
            MessageLookupByLibrary.simpleMessage("carbohydrate"),
        "carbohydratesLabel":
            MessageLookupByLibrary.simpleMessage("Carbohydrates"),
        "carbsLabel": MessageLookupByLibrary.simpleMessage("carbs"),
        "chooseWeightGoalLabel":
            MessageLookupByLibrary.simpleMessage("Choose Weight Goal"),
        "cmLabel": MessageLookupByLibrary.simpleMessage("cm"),
        "coachStudentsLabel":
            MessageLookupByLibrary.simpleMessage("My students"),
        "copyDialogTitle": MessageLookupByLibrary.simpleMessage(
            "Which meal type do you want to copy to?"),
        "copyOrDeleteTimeDialogContent": MessageLookupByLibrary.simpleMessage(
            "With \"Copy to today\" you can copy the meal to today. With \"Delete\" you can delete the meal."),
        "copyOrDeleteTimeDialogTitle":
            MessageLookupByLibrary.simpleMessage("What do you want to do?"),
        "createCustomDialogContent": MessageLookupByLibrary.simpleMessage(
            "Do you want create a custom meal item?"),
        "createCustomDialogTitle":
            MessageLookupByLibrary.simpleMessage("Create custom meal item?"),
        "createRecipeLabel":
            MessageLookupByLibrary.simpleMessage("Create a meal"),
        "dailyKcalAdjustmentLabel":
            MessageLookupByLibrary.simpleMessage("Daily Kcal adjustment:"),
        "dataCollectionLabel": MessageLookupByLibrary.simpleMessage(
            "Support development by providing anonymous usage data"),
        "deleteAllLabel": MessageLookupByLibrary.simpleMessage("Delete all"),
        "deleteTimeDialogContent": MessageLookupByLibrary.simpleMessage(
            "Do want to delete the selected item?"),
        "deleteTimeDialogPluralContent": MessageLookupByLibrary.simpleMessage(
            "Do want to delete all items of this meal?"),
        "deleteTimeDialogPluralTitle":
            MessageLookupByLibrary.simpleMessage("Delete Items?"),
        "deleteTimeDialogTitle":
            MessageLookupByLibrary.simpleMessage("Delete Item?"),
        "deltaWeightBody": MessageLookupByLibrary.simpleMessage(
            "The weight delta is the difference between the average weight and the current weight entered for this day.\nIf no weight is recorded for the current day, the last valid weight will be used."),
        "deltaWeightLabel":
            MessageLookupByLibrary.simpleMessage("Weight Delta"),
        "dialogCancelLabel": MessageLookupByLibrary.simpleMessage("CANCEL"),
        "dialogCopyLabel":
            MessageLookupByLibrary.simpleMessage("Copy to today"),
        "dialogDeleteLabel": MessageLookupByLibrary.simpleMessage("DELETE"),
        "dialogOKLabel": MessageLookupByLibrary.simpleMessage("OK"),
        "diaryLabel": MessageLookupByLibrary.simpleMessage("Diary"),
        "dinnerExample": MessageLookupByLibrary.simpleMessage(
            "e.g. soup, chicken, wine ..."),
        "dinnerLabel": MessageLookupByLibrary.simpleMessage("Dinner"),
        "editItemDialogTitle":
            MessageLookupByLibrary.simpleMessage("Edit item"),
        "editMealLabel": MessageLookupByLibrary.simpleMessage("Edit meal"),
        "energyLabel": MessageLookupByLibrary.simpleMessage("energy"),
        "errorFetchingProductData": MessageLookupByLibrary.simpleMessage(
            "Error while fetching product data"),
        "errorLoadingActivities": MessageLookupByLibrary.simpleMessage(
            "Error while loading activities"),
        "errorMealSave": MessageLookupByLibrary.simpleMessage(
            "Error while saving meal. Did you input the correct meal information?"),
        "errorOpeningBrowser": MessageLookupByLibrary.simpleMessage(
            "Error while opening browser app"),
        "errorOpeningEmail": MessageLookupByLibrary.simpleMessage(
            "Error while opening email app"),
        "errorPrefix": MessageLookupByLibrary.simpleMessage("Error:"),
        "errorProductNotFound":
            MessageLookupByLibrary.simpleMessage("Product not found"),
        "errorRecipeLabel":
            MessageLookupByLibrary.simpleMessage("No recipe found"),
        "exampleOfActivityLabel":
            MessageLookupByLibrary.simpleMessage("e.g. biking"),
        "exportAction": MessageLookupByLibrary.simpleMessage("Export"),
        "exportImportDescription": MessageLookupByLibrary.simpleMessage(
            "You can export the app data to a zip file and import it later. This is useful if you want to backup your data or transfer it to another device.\n\nThe app does not use any cloud service to store your data."),
        "exportImportErrorLabel":
            MessageLookupByLibrary.simpleMessage("Export / Import error"),
        "exportImportLabel":
            MessageLookupByLibrary.simpleMessage("Export / Import data"),
        "exportImportSuccessLabel":
            MessageLookupByLibrary.simpleMessage("Export / Import successful"),
        "exportImportSupabaseDescription": MessageLookupByLibrary.simpleMessage(
            "Backup your data to Supabase storage as a zip file or restore it from there."),
        "exportImportSupabaseLabel": MessageLookupByLibrary.simpleMessage(
            "Export / Import with Supabase"),
        "exportSupabaseDescription": MessageLookupByLibrary.simpleMessage(
            "Backup your data to Supabase storage as a zip file."),
        "exportSupabaseLabel":
            MessageLookupByLibrary.simpleMessage("Export to Supabase"),
        "fatLabel": MessageLookupByLibrary.simpleMessage("fat"),
        "fatsLabel": MessageLookupByLibrary.simpleMessage("Fats"),
        "fiberLabel": MessageLookupByLibrary.simpleMessage("fiber"),
        "flOzUnit": MessageLookupByLibrary.simpleMessage("fl.oz"),
        "forgotPasswordBackToLogin":
            MessageLookupByLibrary.simpleMessage("Back to sign in"),
        "forgotPasswordButton":
            MessageLookupByLibrary.simpleMessage("Send password reset email"),
        "forgotPasswordEmailLabel":
            MessageLookupByLibrary.simpleMessage("Enter your email"),
        "forgotPasswordEmailSent": MessageLookupByLibrary.simpleMessage(
            "Email sent! Click the link in your email to choose a new password."),
        "forgotPasswordSendError":
            MessageLookupByLibrary.simpleMessage("Error sending email:"),
        "forgotPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Forgot your password?"),
        "ftLabel": MessageLookupByLibrary.simpleMessage("ft"),
        "genderFemaleLabel": MessageLookupByLibrary.simpleMessage("♀ female"),
        "genderLabel": MessageLookupByLibrary.simpleMessage("Gender"),
        "genderMaleLabel": MessageLookupByLibrary.simpleMessage("♂ male"),
        "goalGainWeight": MessageLookupByLibrary.simpleMessage("Gain Weight"),
        "goalLabel": MessageLookupByLibrary.simpleMessage("Goal"),
        "goalLoseWeight": MessageLookupByLibrary.simpleMessage("Lose Weight"),
        "goalMaintainWeight":
            MessageLookupByLibrary.simpleMessage("Maintain Weight"),
        "gramMilliliterUnit": MessageLookupByLibrary.simpleMessage("g/ml"),
        "gramUnit": MessageLookupByLibrary.simpleMessage("g"),
        "heightLabel": MessageLookupByLibrary.simpleMessage("Height"),
        "homeLabel": MessageLookupByLibrary.simpleMessage("Home"),
        "importAction": MessageLookupByLibrary.simpleMessage("Import"),
        "importSupabaseDescription": MessageLookupByLibrary.simpleMessage(
            "Restore your data from a backup stored in Supabase."),
        "importSupabaseLabel":
            MessageLookupByLibrary.simpleMessage("Import from Supabase"),
        "infoAddedActivityLabel":
            MessageLookupByLibrary.simpleMessage("Added new activity"),
        "infoAddedIntakeLabel":
            MessageLookupByLibrary.simpleMessage("Added new intake"),
        "itemDeletedSnackbar":
            MessageLookupByLibrary.simpleMessage("Item deleted"),
        "itemUpdatedSnackbar":
            MessageLookupByLibrary.simpleMessage("Item updated"),
        "kcalLabel": MessageLookupByLibrary.simpleMessage("kcal"),
        "kcalLeftLabel": MessageLookupByLibrary.simpleMessage("kcal left"),
        "kgLabel": MessageLookupByLibrary.simpleMessage("kg"),
        "lbsLabel": MessageLookupByLibrary.simpleMessage("lbs"),
        "loginAlreadySignedIn": MessageLookupByLibrary.simpleMessage(
            "Already signed in on another device. Please sign out first."),
        "loginButton": MessageLookupByLibrary.simpleMessage("Sign In"),
        "loginEmailInvalid":
            MessageLookupByLibrary.simpleMessage("Invalid email address"),
        "loginEmailLabel": MessageLookupByLibrary.simpleMessage("Email"),
        "loginEmailRequired":
            MessageLookupByLibrary.simpleMessage("Email required"),
        "loginError": MessageLookupByLibrary.simpleMessage("Sign in error"),
        "loginForgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot password?"),
        "loginPasswordLabel": MessageLookupByLibrary.simpleMessage("Password"),
        "loginTitle": MessageLookupByLibrary.simpleMessage("Sign In"),
        "loginUnknownError":
            MessageLookupByLibrary.simpleMessage("Unknown error"),
        "lunchExample":
            MessageLookupByLibrary.simpleMessage("e.g. pizza, salad, rice ..."),
        "lunchLabel": MessageLookupByLibrary.simpleMessage("Lunch"),
        "macroDistributionLabel":
            MessageLookupByLibrary.simpleMessage("Macronutrient Distribution:"),
        "manageAccountConfirmAction":
            MessageLookupByLibrary.simpleMessage("Confirm Deletion"),
        "manageAccountConfirmMessage": MessageLookupByLibrary.simpleMessage(
            "This action cannot be undone."),
        "manageAccountConfirmTitle":
            MessageLookupByLibrary.simpleMessage("Are you sure?"),
        "manageAccountDelete":
            MessageLookupByLibrary.simpleMessage("Delete My Account"),
        "manageAccountDescription": MessageLookupByLibrary.simpleMessage(
            "We only collect data essential to the proper functioning of the app:\n\nEmail address: used for login and account identification.\n\nNutrition data: your daily weight, calories, protein, fat, and carbohydrate intake.\n\nGoals: your personalized targets for calories, protein, fat, and carbs.\n\nAll data is securely stored on Supabase. We do not share any of your data with third parties."),
        "manageAccountEnableSync":
            MessageLookupByLibrary.simpleMessage("Enable Supabase Sync"),
        "manageAccountTitle":
            MessageLookupByLibrary.simpleMessage("Manage account"),
        "mealBrandsLabel": MessageLookupByLibrary.simpleMessage("Brands"),
        "mealCarbsLabel": MessageLookupByLibrary.simpleMessage("carbs per"),
        "mealFatLabel": MessageLookupByLibrary.simpleMessage("fat per"),
        "mealKcalLabel": MessageLookupByLibrary.simpleMessage("kcal per"),
        "mealNameLabel": MessageLookupByLibrary.simpleMessage("Meal name"),
        "mealPortionLabel":
            MessageLookupByLibrary.simpleMessage("Number of portions"),
        "mealProteinLabel":
            MessageLookupByLibrary.simpleMessage("protein per 100 g/ml"),
        "mealSizeLabel":
            MessageLookupByLibrary.simpleMessage("Meal size (g/ml)"),
        "mealSizeLabelImperial":
            MessageLookupByLibrary.simpleMessage("Meal size (oz/fl oz)"),
        "mealUnitLabel": MessageLookupByLibrary.simpleMessage("Meal unit"),
        "milliliterUnit": MessageLookupByLibrary.simpleMessage("ml"),
        "missingProductInfo": MessageLookupByLibrary.simpleMessage(
            "Product missing required kcal or macronutrients information"),
        "myStudentsTitle": MessageLookupByLibrary.simpleMessage("My students"),
        "noActivityRecentlyAddedLabel":
            MessageLookupByLibrary.simpleMessage("No activity recently added"),
        "noDataToday":
            MessageLookupByLibrary.simpleMessage("No data for today"),
        "noFoodAddedLabel":
            MessageLookupByLibrary.simpleMessage("No food added"),
        "noInternetConnectionMessage": MessageLookupByLibrary.simpleMessage(
            "No internet connection. Feature unavailable."),
        "noMealsRecentlyAddedLabel":
            MessageLookupByLibrary.simpleMessage("No meals recently added"),
        "noResultsFound":
            MessageLookupByLibrary.simpleMessage("No results found"),
        "noStudents": MessageLookupByLibrary.simpleMessage("No students"),
        "notAvailableLabel": MessageLookupByLibrary.simpleMessage("N/A"),
        "nothingAddedLabel":
            MessageLookupByLibrary.simpleMessage("Nothing added"),
        "nutritionInfoLabel":
            MessageLookupByLibrary.simpleMessage("Nutrition Information"),
        "nutritionalStatusNormalWeight":
            MessageLookupByLibrary.simpleMessage("Normal Weight"),
        "nutritionalStatusObeseClassI":
            MessageLookupByLibrary.simpleMessage("Obesity Class I"),
        "nutritionalStatusObeseClassII":
            MessageLookupByLibrary.simpleMessage("Obesity Class II"),
        "nutritionalStatusObeseClassIII":
            MessageLookupByLibrary.simpleMessage("Obesity Class III"),
        "nutritionalStatusPreObesity":
            MessageLookupByLibrary.simpleMessage("Pre-obesity"),
        "nutritionalStatusRiskAverage":
            MessageLookupByLibrary.simpleMessage("Average"),
        "nutritionalStatusRiskIncreased":
            MessageLookupByLibrary.simpleMessage("Increased"),
        "nutritionalStatusRiskLabel": m2,
        "nutritionalStatusRiskLow": MessageLookupByLibrary.simpleMessage(
            "Low \n(but risk of other \nclinical problems increased)"),
        "nutritionalStatusRiskModerate":
            MessageLookupByLibrary.simpleMessage("Moderate"),
        "nutritionalStatusRiskSevere":
            MessageLookupByLibrary.simpleMessage("Severe"),
        "nutritionalStatusRiskVerySevere":
            MessageLookupByLibrary.simpleMessage("Very severe"),
        "nutritionalStatusUnderweight":
            MessageLookupByLibrary.simpleMessage("Underweight"),
        "ozUnit": MessageLookupByLibrary.simpleMessage("oz"),
        "paAmericanFootballGeneral":
            MessageLookupByLibrary.simpleMessage("football"),
        "paAmericanFootballGeneralDesc":
            MessageLookupByLibrary.simpleMessage("touch, flag, general"),
        "paArcheryGeneral": MessageLookupByLibrary.simpleMessage("archery"),
        "paArcheryGeneralDesc":
            MessageLookupByLibrary.simpleMessage("non-hunting"),
        "paAutoRacing": MessageLookupByLibrary.simpleMessage("auto racing"),
        "paAutoRacingDesc": MessageLookupByLibrary.simpleMessage("open wheel"),
        "paBackpackingGeneral":
            MessageLookupByLibrary.simpleMessage("backpacking"),
        "paBackpackingGeneralDesc":
            MessageLookupByLibrary.simpleMessage("general"),
        "paBadmintonGeneral": MessageLookupByLibrary.simpleMessage("badminton"),
        "paBadmintonGeneralDesc": MessageLookupByLibrary.simpleMessage(
            "social singles and doubles, general"),
        "paBasketballGeneral":
            MessageLookupByLibrary.simpleMessage("basketball"),
        "paBasketballGeneralDesc":
            MessageLookupByLibrary.simpleMessage("general"),
        "paBicyclingGeneral": MessageLookupByLibrary.simpleMessage("bicycling"),
        "paBicyclingGeneralDesc":
            MessageLookupByLibrary.simpleMessage("general"),
        "paBicyclingMountainGeneral":
            MessageLookupByLibrary.simpleMessage("bicycling, mountain"),
        "paBicyclingMountainGeneralDesc":
            MessageLookupByLibrary.simpleMessage("general"),
        "paBicyclingStationaryGeneral":
            MessageLookupByLibrary.simpleMessage("bicycling, stationary"),
        "paBicyclingStationaryGeneralDesc":
            MessageLookupByLibrary.simpleMessage("general"),
        "paBilliardsGeneral": MessageLookupByLibrary.simpleMessage("billiards"),
        "paBilliardsGeneralDesc":
            MessageLookupByLibrary.simpleMessage("general"),
        "paBowlingGeneral": MessageLookupByLibrary.simpleMessage("bowling"),
        "paBowlingGeneralDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paBoxingBag": MessageLookupByLibrary.simpleMessage("boxing"),
        "paBoxingBagDesc": MessageLookupByLibrary.simpleMessage("punching bag"),
        "paBoxingGeneral": MessageLookupByLibrary.simpleMessage("boxing"),
        "paBoxingGeneralDesc":
            MessageLookupByLibrary.simpleMessage("in ring, general"),
        "paBroomball": MessageLookupByLibrary.simpleMessage("broomball"),
        "paBroomballDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paCalisthenicsGeneral":
            MessageLookupByLibrary.simpleMessage("calisthenics"),
        "paCalisthenicsGeneralDesc": MessageLookupByLibrary.simpleMessage(
            "light or moderate effort, general (e.g., back exercises)"),
        "paCanoeingGeneral": MessageLookupByLibrary.simpleMessage("canoeing"),
        "paCanoeingGeneralDesc": MessageLookupByLibrary.simpleMessage(
            "rowing, for pleasure, general"),
        "paCatch": MessageLookupByLibrary.simpleMessage("football or baseball"),
        "paCatchDesc": MessageLookupByLibrary.simpleMessage("playing catch"),
        "paCheerleading": MessageLookupByLibrary.simpleMessage("cheerleading"),
        "paCheerleadingDesc": MessageLookupByLibrary.simpleMessage(
            "gymnastic moves, competitive"),
        "paChildrenGame":
            MessageLookupByLibrary.simpleMessage("children’s games"),
        "paChildrenGameDesc": MessageLookupByLibrary.simpleMessage(
            "(e.g., hopscotch, 4-square, dodgeball, playground apparatus, t-ball, tetherball, marbles, arcade games), moderate effort"),
        "paClimbingHillsNoLoadGeneral":
            MessageLookupByLibrary.simpleMessage("climbing hills, no load"),
        "paClimbingHillsNoLoadGeneralDesc":
            MessageLookupByLibrary.simpleMessage("no load"),
        "paCricket": MessageLookupByLibrary.simpleMessage("cricket"),
        "paCricketDesc":
            MessageLookupByLibrary.simpleMessage("batting, bowling, fielding"),
        "paCroquet": MessageLookupByLibrary.simpleMessage("croquet"),
        "paCroquetDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paCurling": MessageLookupByLibrary.simpleMessage("curling"),
        "paCurlingDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paDancingAerobicGeneral":
            MessageLookupByLibrary.simpleMessage("aerobic"),
        "paDancingAerobicGeneralDesc":
            MessageLookupByLibrary.simpleMessage("general"),
        "paDancingGeneral":
            MessageLookupByLibrary.simpleMessage("general dancing"),
        "paDancingGeneralDesc": MessageLookupByLibrary.simpleMessage(
            "e.g. disco, folk, Irish step dancing, line dancing, polka, contra, country"),
        "paDartsWall": MessageLookupByLibrary.simpleMessage("darts"),
        "paDartsWallDesc": MessageLookupByLibrary.simpleMessage("wall or lawn"),
        "paDivingGeneral": MessageLookupByLibrary.simpleMessage("diving"),
        "paDivingGeneralDesc": MessageLookupByLibrary.simpleMessage(
            "skindiving, scuba diving, general"),
        "paDivingSpringboardPlatform":
            MessageLookupByLibrary.simpleMessage("diving"),
        "paDivingSpringboardPlatformDesc":
            MessageLookupByLibrary.simpleMessage("springboard or platform"),
        "paFencing": MessageLookupByLibrary.simpleMessage("fencing"),
        "paFencingDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paFrisbee": MessageLookupByLibrary.simpleMessage("frisbee playing"),
        "paFrisbeeDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paGeneralDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paGolfGeneral": MessageLookupByLibrary.simpleMessage("golf"),
        "paGolfGeneralDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paGymnasticsGeneral":
            MessageLookupByLibrary.simpleMessage("gymnastics"),
        "paGymnasticsGeneralDesc":
            MessageLookupByLibrary.simpleMessage("general"),
        "paHackySack": MessageLookupByLibrary.simpleMessage("hacky sack"),
        "paHackySackDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paHandballGeneral": MessageLookupByLibrary.simpleMessage("handball"),
        "paHandballGeneralDesc":
            MessageLookupByLibrary.simpleMessage("general"),
        "paHangGliding": MessageLookupByLibrary.simpleMessage("hang gliding"),
        "paHangGlidingDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paHeadingBicycling": MessageLookupByLibrary.simpleMessage("bicycling"),
        "paHeadingConditionalExercise":
            MessageLookupByLibrary.simpleMessage("conditioning exercise"),
        "paHeadingDancing": MessageLookupByLibrary.simpleMessage("dancing"),
        "paHeadingRunning": MessageLookupByLibrary.simpleMessage("running"),
        "paHeadingSports": MessageLookupByLibrary.simpleMessage("sports"),
        "paHeadingWalking": MessageLookupByLibrary.simpleMessage("walking"),
        "paHeadingWaterActivities":
            MessageLookupByLibrary.simpleMessage("water activities"),
        "paHeadingWinterActivities":
            MessageLookupByLibrary.simpleMessage("winter activities"),
        "paHikingCrossCountry": MessageLookupByLibrary.simpleMessage("hiking"),
        "paHikingCrossCountryDesc":
            MessageLookupByLibrary.simpleMessage("cross country"),
        "paHockeyField": MessageLookupByLibrary.simpleMessage("hockey, field"),
        "paHockeyFieldDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paHorseRidingGeneral":
            MessageLookupByLibrary.simpleMessage("horseback riding"),
        "paHorseRidingGeneralDesc":
            MessageLookupByLibrary.simpleMessage("general"),
        "paIceHockeyGeneral":
            MessageLookupByLibrary.simpleMessage("ice hockey"),
        "paIceHockeyGeneralDesc":
            MessageLookupByLibrary.simpleMessage("general"),
        "paIceSkatingGeneral":
            MessageLookupByLibrary.simpleMessage("ice skating"),
        "paIceSkatingGeneralDesc":
            MessageLookupByLibrary.simpleMessage("general"),
        "paJaiAlai": MessageLookupByLibrary.simpleMessage("jai alai"),
        "paJaiAlaiDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paJoggingGeneral": MessageLookupByLibrary.simpleMessage("jogging"),
        "paJoggingGeneralDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paJuggling": MessageLookupByLibrary.simpleMessage("juggling"),
        "paJugglingDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paKayakingModerate": MessageLookupByLibrary.simpleMessage("kayaking"),
        "paKayakingModerateDesc":
            MessageLookupByLibrary.simpleMessage("moderate effort"),
        "paKickball": MessageLookupByLibrary.simpleMessage("kickball"),
        "paKickballDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paLacrosse": MessageLookupByLibrary.simpleMessage("lacrosse"),
        "paLacrosseDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paLawnBowling": MessageLookupByLibrary.simpleMessage("lawn bowling"),
        "paLawnBowlingDesc":
            MessageLookupByLibrary.simpleMessage("bocce ball, outdoor"),
        "paMartialArtsModerate":
            MessageLookupByLibrary.simpleMessage("martial arts"),
        "paMartialArtsModerateDesc": MessageLookupByLibrary.simpleMessage(
            "different types, moderate pace (e.g., judo, jujitsu, karate, kick boxing, tae kwan do, tai-bo, Muay Thai boxing)"),
        "paMartialArtsSlower":
            MessageLookupByLibrary.simpleMessage("martial arts"),
        "paMartialArtsSlowerDesc": MessageLookupByLibrary.simpleMessage(
            "different types, slower pace, novice performers, practice"),
        "paMotoCross": MessageLookupByLibrary.simpleMessage("moto-cross"),
        "paMotoCrossDesc": MessageLookupByLibrary.simpleMessage(
            "off-road motor sports, all-terrain vehicle, general"),
        "paMountainClimbing": MessageLookupByLibrary.simpleMessage("climbing"),
        "paMountainClimbingDesc":
            MessageLookupByLibrary.simpleMessage("rock or mountain climbing"),
        "paOrienteering": MessageLookupByLibrary.simpleMessage("orienteering"),
        "paOrienteeringDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paPaddleBoarding":
            MessageLookupByLibrary.simpleMessage("paddle boarding"),
        "paPaddleBoardingDesc":
            MessageLookupByLibrary.simpleMessage("standing"),
        "paPaddleBoat": MessageLookupByLibrary.simpleMessage("paddle boat"),
        "paPaddleBoatDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paPaddleball": MessageLookupByLibrary.simpleMessage("paddleball"),
        "paPaddleballDesc":
            MessageLookupByLibrary.simpleMessage("casual, general"),
        "paPoloHorse": MessageLookupByLibrary.simpleMessage("polo"),
        "paPoloHorseDesc": MessageLookupByLibrary.simpleMessage("on horseback"),
        "paRacquetball": MessageLookupByLibrary.simpleMessage("racquetball"),
        "paRacquetballDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paResistanceTraining":
            MessageLookupByLibrary.simpleMessage("resistance training"),
        "paResistanceTrainingDesc": MessageLookupByLibrary.simpleMessage(
            "weight lifting, free weight, nautilus or universal"),
        "paRodeoSportGeneralModerate":
            MessageLookupByLibrary.simpleMessage("rodeo sports"),
        "paRodeoSportGeneralModerateDesc":
            MessageLookupByLibrary.simpleMessage("general, moderate effort"),
        "paRollerbladingLight":
            MessageLookupByLibrary.simpleMessage("rollerblading"),
        "paRollerbladingLightDesc":
            MessageLookupByLibrary.simpleMessage("in-line skating"),
        "paRopeJumpingGeneral":
            MessageLookupByLibrary.simpleMessage("rope jumping"),
        "paRopeJumpingGeneralDesc": MessageLookupByLibrary.simpleMessage(
            "moderate pace, 100-120 skips/min, general, 2 foot skip, plain bounce"),
        "paRopeSkippingGeneral":
            MessageLookupByLibrary.simpleMessage("rope skipping"),
        "paRopeSkippingGeneralDesc":
            MessageLookupByLibrary.simpleMessage("general"),
        "paRugbyCompetitive": MessageLookupByLibrary.simpleMessage("rugby"),
        "paRugbyCompetitiveDesc":
            MessageLookupByLibrary.simpleMessage("union, team, competitive"),
        "paRugbyNonCompetitive": MessageLookupByLibrary.simpleMessage("rugby"),
        "paRugbyNonCompetitiveDesc":
            MessageLookupByLibrary.simpleMessage("touch, non-competitive"),
        "paRunningGeneral": MessageLookupByLibrary.simpleMessage("running"),
        "paRunningGeneralDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paSailingGeneral": MessageLookupByLibrary.simpleMessage("sailing"),
        "paSailingGeneralDesc": MessageLookupByLibrary.simpleMessage(
            "boat and board sailing, windsurfing, ice sailing, general"),
        "paShuffleboard": MessageLookupByLibrary.simpleMessage("shuffleboard"),
        "paShuffleboardDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paSkateboardingGeneral":
            MessageLookupByLibrary.simpleMessage("skateboarding"),
        "paSkateboardingGeneralDesc":
            MessageLookupByLibrary.simpleMessage("general, moderate effort"),
        "paSkatingRoller":
            MessageLookupByLibrary.simpleMessage("roller skating"),
        "paSkatingRollerDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paSkiingGeneral": MessageLookupByLibrary.simpleMessage("skiing"),
        "paSkiingGeneralDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paSkiingWaterWakeboarding":
            MessageLookupByLibrary.simpleMessage("water skiing"),
        "paSkiingWaterWakeboardingDesc":
            MessageLookupByLibrary.simpleMessage("water or wakeboarding"),
        "paSkydiving": MessageLookupByLibrary.simpleMessage("skydiving"),
        "paSkydivingDesc": MessageLookupByLibrary.simpleMessage(
            "skydiving, base jumping, bungee jumping"),
        "paSnorkeling": MessageLookupByLibrary.simpleMessage("snorkeling"),
        "paSnorkelingDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paSnowShovingModerate":
            MessageLookupByLibrary.simpleMessage("snow shoveling"),
        "paSnowShovingModerateDesc":
            MessageLookupByLibrary.simpleMessage("by hand, moderate effort"),
        "paSoccerGeneral": MessageLookupByLibrary.simpleMessage("soccer"),
        "paSoccerGeneralDesc":
            MessageLookupByLibrary.simpleMessage("casual, general"),
        "paSoftballBaseballGeneral":
            MessageLookupByLibrary.simpleMessage("softball / baseball"),
        "paSoftballBaseballGeneralDesc":
            MessageLookupByLibrary.simpleMessage("fast or slow pitch, general"),
        "paSquashGeneral": MessageLookupByLibrary.simpleMessage("squash"),
        "paSquashGeneralDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paSurfing": MessageLookupByLibrary.simpleMessage("surfing"),
        "paSurfingDesc":
            MessageLookupByLibrary.simpleMessage("body or board, general"),
        "paSwimmingGeneral": MessageLookupByLibrary.simpleMessage("swimming"),
        "paSwimmingGeneralDesc": MessageLookupByLibrary.simpleMessage(
            "treading water, moderate effort, general"),
        "paTableTennisGeneral":
            MessageLookupByLibrary.simpleMessage("table tennis"),
        "paTableTennisGeneralDesc":
            MessageLookupByLibrary.simpleMessage("table tennis, ping pong"),
        "paTaiChiQiGongGeneral":
            MessageLookupByLibrary.simpleMessage("tai chi, qi gong"),
        "paTaiChiQiGongGeneralDesc":
            MessageLookupByLibrary.simpleMessage("general"),
        "paTennisGeneral": MessageLookupByLibrary.simpleMessage("tennis"),
        "paTennisGeneralDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paTrackField": MessageLookupByLibrary.simpleMessage("track and field"),
        "paTrackField1Desc": MessageLookupByLibrary.simpleMessage(
            "(e.g. shot, discus, hammer throw)"),
        "paTrackField2Desc": MessageLookupByLibrary.simpleMessage(
            "(e.g. high jump, long jump, triple jump, javelin, pole vault)"),
        "paTrackField3Desc": MessageLookupByLibrary.simpleMessage(
            "(e.g. steeplechase, hurdles)"),
        "paTrampolineLight": MessageLookupByLibrary.simpleMessage("trampoline"),
        "paTrampolineLightDesc":
            MessageLookupByLibrary.simpleMessage("recreational"),
        "paUnicyclingGeneral":
            MessageLookupByLibrary.simpleMessage("unicycling"),
        "paUnicyclingGeneralDesc":
            MessageLookupByLibrary.simpleMessage("general"),
        "paVolleyballGeneral":
            MessageLookupByLibrary.simpleMessage("volleyball"),
        "paVolleyballGeneralDesc": MessageLookupByLibrary.simpleMessage(
            "non-competitive, 6 - 9 member team, general"),
        "paWalkingForPleasure": MessageLookupByLibrary.simpleMessage("walking"),
        "paWalkingForPleasureDesc":
            MessageLookupByLibrary.simpleMessage("for pleasure"),
        "paWalkingTheDog":
            MessageLookupByLibrary.simpleMessage("walking the dog"),
        "paWalkingTheDogDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paWallyball": MessageLookupByLibrary.simpleMessage("wallyball"),
        "paWallyballDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paWaterAerobics":
            MessageLookupByLibrary.simpleMessage("water exercise"),
        "paWaterAerobicsDesc": MessageLookupByLibrary.simpleMessage(
            "water aerobics, water calisthenics"),
        "paWaterPolo": MessageLookupByLibrary.simpleMessage("water polo"),
        "paWaterPoloDesc": MessageLookupByLibrary.simpleMessage("general"),
        "paWaterVolleyball":
            MessageLookupByLibrary.simpleMessage("water volleyball"),
        "paWaterVolleyballDesc":
            MessageLookupByLibrary.simpleMessage("general"),
        "paWateraerobicsCalisthenics":
            MessageLookupByLibrary.simpleMessage("water aerobics"),
        "paWateraerobicsCalisthenicsDesc": MessageLookupByLibrary.simpleMessage(
            "water aerobics, water calisthenics"),
        "paWrestling": MessageLookupByLibrary.simpleMessage("wrestling"),
        "paWrestlingDesc": MessageLookupByLibrary.simpleMessage("general"),
        "palActiveDescriptionLabel": MessageLookupByLibrary.simpleMessage(
            "Mostly standing or walking in job and active free time activities"),
        "palActiveLabel": MessageLookupByLibrary.simpleMessage("Active"),
        "palLowActiveDescriptionLabel": MessageLookupByLibrary.simpleMessage(
            "e.g. sitting or standing in job and light free time activities"),
        "palLowLActiveLabel":
            MessageLookupByLibrary.simpleMessage("Low Active"),
        "palSedentaryDescriptionLabel": MessageLookupByLibrary.simpleMessage(
            "e.g. office job and mostly sitting free time activities"),
        "palSedentaryLabel": MessageLookupByLibrary.simpleMessage("Sedentary"),
        "palVeryActiveDescriptionLabel": MessageLookupByLibrary.simpleMessage(
            "Mostly walking, running or carrying weight in job and active free time activities"),
        "palVeryActiveLabel":
            MessageLookupByLibrary.simpleMessage("Very Active"),
        "passwordDigit":
            MessageLookupByLibrary.simpleMessage("At least 1 digit"),
        "passwordLowercase":
            MessageLookupByLibrary.simpleMessage("At least 1 lowercase letter"),
        "passwordMinLength":
            MessageLookupByLibrary.simpleMessage("At least 8 characters"),
        "passwordRequired":
            MessageLookupByLibrary.simpleMessage("Password required"),
        "passwordSpecialChar": MessageLookupByLibrary.simpleMessage(
            "At least 1 special character"),
        "passwordUppercase":
            MessageLookupByLibrary.simpleMessage("At least 1 uppercase letter"),
        "per100gmlLabel": MessageLookupByLibrary.simpleMessage("Per 100g/ml"),
        "perServingLabel": MessageLookupByLibrary.simpleMessage("Per Serving"),
        "portionEatLabel":
            MessageLookupByLibrary.simpleMessage("Portion eaten"),
        "privacyPolicyLabel":
            MessageLookupByLibrary.simpleMessage("Privacy policy"),
        "profileLabel": MessageLookupByLibrary.simpleMessage("Profile"),
        "proteinLabel": MessageLookupByLibrary.simpleMessage("protein"),
        "proteinsLabel": MessageLookupByLibrary.simpleMessage("Proteins"),
        "quantityLabel": MessageLookupByLibrary.simpleMessage("Quantity"),
        "readLabel": MessageLookupByLibrary.simpleMessage(
            "I have read and accept the privacy policy."),
        "recentlyAddedLabel": MessageLookupByLibrary.simpleMessage("Recently"),
        "recipeLabel": MessageLookupByLibrary.simpleMessage("Recipe"),
        "reportErrorDialogText": MessageLookupByLibrary.simpleMessage(
            "Do you want to report an error to the developer?"),
        "resetPasswordButton":
            MessageLookupByLibrary.simpleMessage("Change password"),
        "resetPasswordChanged": MessageLookupByLibrary.simpleMessage(
            "Password changed! You can now sign in with your new password."),
        "resetPasswordConfirmLabel":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "resetPasswordNewLabel":
            MessageLookupByLibrary.simpleMessage("New password"),
        "resetPasswordNoMatch":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "resetPasswordTips": MessageLookupByLibrary.simpleMessage(
            "• Use at least 8 characters\n• Mix numbers & special characters\n• Uppercase + lowercase"),
        "resetPasswordTitle":
            MessageLookupByLibrary.simpleMessage("New password"),
        "retryLabel": MessageLookupByLibrary.simpleMessage("Retry"),
        "roleCoachLabel": MessageLookupByLibrary.simpleMessage("Coach"),
        "roleLabel": MessageLookupByLibrary.simpleMessage("Role"),
        "roleStudentLabel": MessageLookupByLibrary.simpleMessage("Student"),
        "saturatedFatLabel":
            MessageLookupByLibrary.simpleMessage("saturated fat"),
        "scanProductLabel":
            MessageLookupByLibrary.simpleMessage("Scan Product"),
        "searchDefaultLabel":
            MessageLookupByLibrary.simpleMessage("Please enter a search word"),
        "searchFoodPage": MessageLookupByLibrary.simpleMessage("Food"),
        "searchLabel": MessageLookupByLibrary.simpleMessage("Search"),
        "searchProductsPage": MessageLookupByLibrary.simpleMessage("Products"),
        "searchResultsLabel":
            MessageLookupByLibrary.simpleMessage("Search results"),
        "selectGenderDialogLabel":
            MessageLookupByLibrary.simpleMessage("Select Gender"),
        "selectHeightDialogLabel":
            MessageLookupByLibrary.simpleMessage("Select Height"),
        "selectPalCategoryLabel":
            MessageLookupByLibrary.simpleMessage("Select Activity Level"),
        "selectRoleDialogLabel":
            MessageLookupByLibrary.simpleMessage("Select Role"),
        "selectWeightDialogLabel":
            MessageLookupByLibrary.simpleMessage("Select Weight"),
        "sendAnonymousUserData":
            MessageLookupByLibrary.simpleMessage("Send anonymous usage data"),
        "servingLabel": MessageLookupByLibrary.simpleMessage("Serving"),
        "servingSizeLabelImperial":
            MessageLookupByLibrary.simpleMessage("Serving size (oz/fl oz)"),
        "servingSizeLabelMetric":
            MessageLookupByLibrary.simpleMessage("Serving size (g/ml)"),
        "setMacrosLabel": MessageLookupByLibrary.simpleMessage("Set macros"),
        "settingAboutLabel": MessageLookupByLibrary.simpleMessage("About"),
        "settingFeedbackLabel":
            MessageLookupByLibrary.simpleMessage("Feedback"),
        "settingsCalculationsLabel":
            MessageLookupByLibrary.simpleMessage("Calculations"),
        "settingsDistanceLabel":
            MessageLookupByLibrary.simpleMessage("Distance"),
        "settingsImperialLabel":
            MessageLookupByLibrary.simpleMessage("Imperial (lbs, ft, oz)"),
        "settingsLabel": MessageLookupByLibrary.simpleMessage("Settings"),
        "settingsLicensesLabel":
            MessageLookupByLibrary.simpleMessage("Licenses"),
        "settingsMassLabel": MessageLookupByLibrary.simpleMessage("Mass"),
        "settingsMetricLabel":
            MessageLookupByLibrary.simpleMessage("Metric (kg, cm, ml)"),
        "settingsPrivacySettings":
            MessageLookupByLibrary.simpleMessage("Privacy Settings"),
        "settingsReportErrorLabel":
            MessageLookupByLibrary.simpleMessage("Report Error"),
        "settingsSourceCodeLabel":
            MessageLookupByLibrary.simpleMessage("Source Code"),
        "settingsSystemLabel": MessageLookupByLibrary.simpleMessage("System"),
        "settingsThemeDarkLabel": MessageLookupByLibrary.simpleMessage("Dark"),
        "settingsThemeLabel": MessageLookupByLibrary.simpleMessage("Theme"),
        "settingsThemeLightLabel":
            MessageLookupByLibrary.simpleMessage("Light"),
        "settingsThemeSystemDefaultLabel":
            MessageLookupByLibrary.simpleMessage("System default"),
        "settingsUnitsLabel": MessageLookupByLibrary.simpleMessage("Units"),
        "settingsVolumeLabel": MessageLookupByLibrary.simpleMessage("Volume"),
        "signOutOfflineMessage": MessageLookupByLibrary.simpleMessage(
            "You can only sign out when internet connection is available to avoid losing data."),
        "signOutSyncFailedMessage": MessageLookupByLibrary.simpleMessage(
            "Failed to sync your data. Please sign in again later."),
        "snackExample": MessageLookupByLibrary.simpleMessage(
            "e.g. apple, ice cream, chocolate ..."),
        "snackLabel": MessageLookupByLibrary.simpleMessage("Snack"),
        "sugarLabel": MessageLookupByLibrary.simpleMessage("sugar"),
        "suppliedLabel": MessageLookupByLibrary.simpleMessage("supplied"),
        "unitLabel": MessageLookupByLibrary.simpleMessage("Unit"),
        "weightLabel": MessageLookupByLibrary.simpleMessage("Weight"),
        "yearsLabel": m3
      };
}
