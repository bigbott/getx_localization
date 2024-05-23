import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_localization/common/language_list.dart';
import 'package:getx_localization/controller/lang_settings_controller.dart';

class LangSettingsScreen extends StatelessWidget {
  const LangSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langSettingsController = Get.find<LangSettingsController>();
    var langTag = langSettingsController.langSettings.lang.split('-')[0];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${'Language'.tr}:',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              LanguageList.getDisplayLanguage(langTag).tr,
              style: const TextStyle(fontSize: 14),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: langSettingsController.supportedLangs.length,
            itemBuilder: (BuildContext context, int index) {
              String tag = langSettingsController.supportedLangs[index];
              String langSubtag = tag.split('-')[0];
              return Center(
                child: SizedBox(
                  width: 300,
                  child: ListTile(
                    //leading: const Icon(Icons.circle),
                    selectedColor: Get.theme.colorScheme.tertiary,
                    selected: tag == langSettingsController.langSettings.lang,
                    title: Text(
                      LanguageList.getDisplayLanguage(langSubtag).tr,
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => langSettingsController.setLang(tag),
                    trailing: tag == langSettingsController.langSettings.lang
                        ? const Icon(Icons.check)
                        : Icon(Icons.check, color: Colors.white.withOpacity(0)),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
