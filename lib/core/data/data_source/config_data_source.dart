import 'package:logging/logging.dart';

import 'package:opennutritracker/core/data/dbo/app_theme_dbo.dart';
import 'package:opennutritracker/core/data/dbo/config_dbo.dart';
import 'package:opennutritracker/core/utils/hive_db_provider.dart';

class ConfigDataSource {
  static const String _configKey = 'ConfigKey';

  final _log = Logger('ConfigDataSource');
  final HiveDBProvider _hive;

  ConfigDataSource(this._hive);

  Future<bool> configInitialized() async => _hive.configBox.containsKey(_configKey);

  Future<void> initializeConfig() async =>
      _hive.configBox.put(_configKey, ConfigDBO.empty());

  Future<void> addConfig(ConfigDBO configDBO) async {
    _log.fine('Adding new config item to db');
    _hive.configBox.put(_configKey, configDBO);
  }

  Future<void> setConfigDisclaimer(bool hasAcceptedDisclaimer) async {
    _log.fine(
        'Updating config hasAcceptedDisclaimer to $hasAcceptedDisclaimer');
    final config = _hive.configBox.get(_configKey);
    config?.hasAcceptedDisclaimer = hasAcceptedDisclaimer;
    await config?.save();
  }

  Future<void> setConfigAcceptedAnonymousData(
      bool hasAcceptedAnonymousData) async {
    _log.fine(
        'Updating config hasAcceptedAnonymousData to $hasAcceptedAnonymousData');
    final config = _hive.configBox.get(_configKey);
    config?.hasAcceptedSendAnonymousData = hasAcceptedAnonymousData;
    await config?.save();
  }

  Future<AppThemeDBO> getAppTheme() async {
    final config = _hive.configBox.get(_configKey);
    return config?.selectedAppTheme ?? AppThemeDBO.defaultTheme;
  }

  Future<void> setConfigAppTheme(AppThemeDBO appTheme) async {
    _log.fine('Updating config appTheme to $appTheme');
    final config = _hive.configBox.get(_configKey);
    config?.selectedAppTheme = appTheme;
    await config?.save();
  }

  Future<void> setConfigUsesImperialUnits(bool usesImperialUnits) async {
    _log.fine('Updating config usesImperialUnits to $usesImperialUnits');
    final config = _hive.configBox.get(_configKey);
    config?.usesImperialUnits = usesImperialUnits;
    await config?.save();
  }

  Future<double> getKcalAdjustment() async {
    final config = _hive.configBox.get(_configKey);
    return config?.userKcalAdjustment ?? 0;
  }

  Future<void> setConfigKcalAdjustment(double kcalAdjustment) async {
    _log.fine('Updating config kcalAdjustment to $kcalAdjustment');
    final config = _hive.configBox.get(_configKey);
    config?.userKcalAdjustment = kcalAdjustment;
    await config?.save();
  }

  Future<void> setConfigCarbGoalPct(double carbGoalPct) async {
    _log.fine('Updating config carbGoalPct to $carbGoalPct');
    final config = _hive.configBox.get(_configKey);
    config?.userCarbGoalPct = carbGoalPct;
    await config?.save();
  }

  Future<void> setConfigProteinGoalPct(double proteinGoalPct) async {
    _log.fine('Updating config proteinGoalPct to $proteinGoalPct');
    final config = _hive.configBox.get(_configKey);
    config?.userProteinGoalPct = proteinGoalPct;
    await config?.save();
  }

  Future<void> setConfigFatGoalPct(double fatGoalPct) async {
    _log.fine('Updating config fatGoalPct to $fatGoalPct');
    final config = _hive.configBox.get(_configKey);
    config?.userFatGoalPct = fatGoalPct;
    await config?.save();
  }

  Future<ConfigDBO> getConfig() async {
    return _hive.configBox.get(_configKey) ?? ConfigDBO.empty();
  }

  Future<bool> getHasAcceptedAnonymousData() async {
    final config = _hive.configBox.get(_configKey);
    return config?.hasAcceptedSendAnonymousData ?? false;
  }
}
