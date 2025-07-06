import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';

import 'package:opennutritracker/core/data/dbo/app_theme_dbo.dart';
import 'package:opennutritracker/core/data/dbo/config_dbo.dart';

class ConfigDataSource {
  static const String _configKey = 'ConfigKey';

  final Logger _log = Logger('ConfigDataSource');
  final Box<ConfigDBO> _configBox;

  ConfigDataSource(this._configBox);

  Future<bool> configInitialized() async => _configBox.containsKey(_configKey);
  Future<void> initializeConfig() async =>
      _configBox.put(_configKey, ConfigDBO.empty());

  Future<void> addConfig(ConfigDBO configDBO) async {
    _log.fine('Adding new config item to db');
    await _configBox.put(_configKey, configDBO);
  }

  Future<void> setConfigDisclaimer(bool hasAcceptedDisclaimer) async {
    _log.fine('Updating config hasAcceptedDisclaimer → $hasAcceptedDisclaimer');
    await _mutateConfig((c) => c.hasAcceptedDisclaimer = hasAcceptedDisclaimer);
  }

  Future<void> setConfigAcceptedAnonymousData(bool accepted) async {
    _log.fine('Updating config hasAcceptedAnonymousData → $accepted');
    await _mutateConfig((c) => c.hasAcceptedSendAnonymousData = accepted);
  }

  Future<AppThemeDBO> getAppTheme() async {
    final cfg = _configBox.get(_configKey);
    return cfg?.selectedAppTheme ?? AppThemeDBO.defaultTheme;
  }

  Future<void> setConfigAppTheme(AppThemeDBO theme) async {
    _log.fine('Updating config selectedAppTheme → $theme');
    await _mutateConfig((c) => c.selectedAppTheme = theme);
  }

  Future<void> setConfigUsesImperialUnits(bool usesImperialUnits) async {
    _log.fine('Updating config usesImperialUnits → $usesImperialUnits');
    await _mutateConfig((c) => c.usesImperialUnits = usesImperialUnits);
  }

  Future<double> getKcalAdjustment() async {
    final cfg = _configBox.get(_configKey);
    return cfg?.userKcalAdjustment ?? 0;
  }

  Future<void> setConfigKcalAdjustment(double kcal) async {
    _log.fine('Updating config kcalAdjustment → $kcal');
    await _mutateConfig((c) => c.userKcalAdjustment = kcal);
  }

  Future<void> setConfigCarbGoalPct(double pct) async {
    _log.fine('Updating config carbGoalPct → $pct');
    await _mutateConfig((c) => c.userCarbGoalPct = pct);
  }

  Future<void> setConfigProteinGoalPct(double pct) async {
    _log.fine('Updating config proteinGoalPct → $pct');
    await _mutateConfig((c) => c.userProteinGoalPct = pct);
  }

  Future<void> setConfigFatGoalPct(double pct) async {
    _log.fine('Updating config fatGoalPct → $pct');
    await _mutateConfig((c) => c.userFatGoalPct = pct);
  }

  Future<ConfigDBO> getConfig() async =>
      _configBox.get(_configKey) ?? ConfigDBO.empty();

  Future<bool> getHasAcceptedAnonymousData() async {
    final cfg = _configBox.get(_configKey);
    return cfg?.hasAcceptedSendAnonymousData ?? false;
  }

  Future<void> setUserActivityLastUpdate(DateTime date) async =>
      _updateDate((c) => c.userActivityLastUpdate = date);
  Future<DateTime?> getUserActivityLastUpdate() async =>
      _configBox.get(_configKey)?.userActivityLastUpdate;

  Future<void> setUserIntakeLastUpdate(DateTime date) async =>
      _updateDate((c) => c.userIntakeLastUpdate = date);
  Future<DateTime?> getUserIntakeLastUpdate() async =>
      _configBox.get(_configKey)?.userIntakeLastUpdate;

  Future<void> setTrackedDayLastUpdate(DateTime date) async =>
      _updateDate((c) => c.trackedDayLastUpdate = date);
  Future<DateTime?> getTrackedDayLastUpdate() async =>
      _configBox.get(_configKey)?.trackedDayLastUpdate;

  Future<void> setUserWeightLastUpdate(DateTime date) async =>
      _updateDate((c) => c.userWeightLastUpdate = date);
  Future<DateTime?> getUserWeightLastUpdate() async =>
      _configBox.get(_configKey)?.userWeightLastUpdate;

  Future<void> _updateDate(void Function(ConfigDBO) fn) async =>
      _mutateConfig(fn);

  Future<void> _mutateConfig(void Function(ConfigDBO) mutate) async {
    final cfg = _configBox.get(_configKey);
    if (cfg == null) return;
    mutate(cfg);
    await cfg.save();
  }
}
