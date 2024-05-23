import 'package:hive_flutter/hive_flutter.dart';
import 'package:getx_localization/model/theme_settings.dart';
import 'package:getx_localization/service/theme_settings/theme_settings_service.dart';

class HiveThemeSettingsService implements ThemeSettingsService {
  static HiveThemeSettingsService? _instance;
  HiveThemeSettingsService._();
  factory HiveThemeSettingsService() =>
      _instance ??= HiveThemeSettingsService._();

  @override
  ThemeSettings loadSettings() {
    return Hive.box<ThemeSettings>('theme_settings_box')
            .get('theme_settings') ??
        ThemeSettings();
  }

  @override
  void saveSettings(ThemeSettings settings) {
    Hive.box<ThemeSettings>('theme_settings_box')
        .put('theme_settings', settings);
  }
}
