//import 'dart:io';


import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_localization/model/lang_settings.dart';
import 'package:getx_localization/service/lang_settings/lang_settings_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:universal_io/io.dart';

class HiveLangSettingsService implements LangSettingsService {
  static HiveLangSettingsService? _instance;
  HiveLangSettingsService._();
  factory HiveLangSettingsService() =>
      _instance ??= HiveLangSettingsService._();

  var langSettings = LangSettings(
    lang: 'en-US',
    messagesJson: '',
  );
  List<String>? supportedLangs;

  Future<void> init() async {
    langSettings.lang = loadLang();
    langSettings.messagesJson = await loadMessages(langSettings.lang);
    supportedLangs = await loadSupportedLanguages();
  }

  @override
  LangSettings getSettings() {
    return langSettings;
  }

  @override
  List<String> getSupportedLangs() {
    return supportedLangs!;
  }

  String loadLang() {
    String? lang = Hive.box<String>('lang_box').get('lang');
    if (lang == null) {
      lang = Get.deviceLocale!.toLanguageTag();
      saveLang(lang);
    }

    return lang;
  }

  @override
  Future<String> loadMessages(String langCode) async {
    String? messagesJson = Hive.box<String>('lang_box').get(langCode);

    if (messagesJson == null) {
      messagesJson =
          await rootBundle.loadString('assets/locales/$langCode.json');
      saveMessages(langCode, messagesJson);
    }

    return messagesJson;
  }

  @override
  void saveLang(String value) {
    Hive.box<String>('lang_box').put('lang', value);
  }

  @override
  void saveMessages(String langCode, messagesJson) {
    Hive.box<String>('lang_box').put(langCode, messagesJson);
  }

  Future<List<String>> loadSupportedLanguages() async {
    List<String>? supportedLanguages =
        Hive.box<List<String>>('lang_list_box').get('lang_list');
    if (supportedLanguages == null) {
      final dir = Directory('assets/locales/');
      final List<FileSystemEntity> entities = await dir.list().toList();
      final Iterable<File> files = entities.whereType<File>();
      supportedLanguages = [];
      for (File file in files) {
        supportedLanguages.add(basename(file.path).replaceAll('.json', ''));
      }
      saveSupportedLanguages(supportedLanguages);
    }
    return supportedLanguages;
  }

  @override
  void saveSupportedLanguages(List<String> value) {
    Hive.box<List<String>>('lang_list_box').put('lang_list', value);
  }
}
