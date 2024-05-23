


import 'package:getx_localization/model/lang_settings.dart';

abstract class LangSettingsService {
  LangSettings getSettings();
  List<String> getSupportedLangs();
 // String loadLang();
  void saveLang(String value);
  Future<String> loadMessages(String langCode);
  void saveMessages(String langCode, String messagesJson);
  //Future<List<String>> loadSupportedLanguages();
  void saveSupportedLanguages(List<String> value);
}