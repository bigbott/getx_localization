import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_localization/common/util.dart';
import 'package:getx_localization/model/lang_settings.dart';
import 'package:getx_localization/model/messages.dart';
import 'package:getx_localization/service/lang_settings/lang_settings_service.dart';

class LangSettingsController extends GetxController {
  final LangSettingsService langSettingsService;

  var langSettings =
      LangSettings(lang: 'en-US', messagesJson: '', );

  LangSettingsController({required this.langSettingsService});

  //String lang = 'en_US';
  //String messagesJson = '';
  List<String> supportedLangs = [];

   Messages? messages;
 // final StaticMessages messages = StaticMessages();

  //bool isInitialized = false;

  @override
  void onInit() async {

    // langSettings.lang = langSettingsService.loadLang();
    // langSettings.messagesJson = await langSettingsService.loadMessages(langSettings.lang);
    // supportedLangs = await langSettingsService.loadSupportedLanguages();

    langSettings = langSettingsService.getSettings();
    supportedLangs =  langSettingsService.getSupportedLangs();

    messages = Messages(languages: {
      langSettings.lang.split('-')[0]:
          jsonToMap(langSettings.messagesJson)
    });

    super.onInit();
  }

  void setLang(String lang) async {
    langSettings.lang = lang;
    langSettings.messagesJson = await langSettingsService.loadMessages(lang);
     messages = Messages(languages: {
      langSettings.lang.split('-')[0]:
          jsonToMap(langSettings.messagesJson)
    });
    print(langSettings.messagesJson);
    Get.clearTranslations();
    Get.addTranslations(messages!.languages);
    Get.updateLocale(tagToLocale(lang));
    update();
  }

  Locale tagToLocale(String tag){
    var tagData = tag.split('-');
    return Locale(tagData[0], tagData[1]);
  }

  List<Locale> tagsToLocales (List<String> tags){
    List<Locale> result = [];
    for (String tag in tags){
      result.add(tagToLocale(tag));
    }
    return result;
  }




}
