
import 'package:getx_localization/model/theme_settings.dart';

abstract class ThemeSettingsService {
  ThemeSettings loadSettings();
  void saveSettings(ThemeSettings settings);
}