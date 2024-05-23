import 'package:hive_flutter/hive_flutter.dart';
import 'package:getx_localization/model/theme_settings.dart';
import 'package:getx_localization/service/theme_settings/theme_settings_adapter.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ThemeSettingsAdapter());
  }
  await Hive.openBox<ThemeSettings>('theme_settings_box');
  var langBox = await Hive.openBox<String>('lang_box');
  var langListBox = await Hive.openBox<List<String>>('lang_list_box');
  langBox.clear();
  langListBox.clear();
}
