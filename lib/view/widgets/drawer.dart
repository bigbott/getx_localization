import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_localization/common/language_list.dart';
import 'package:getx_localization/controller/lang_settings_controller.dart';
import 'package:getx_localization/routes.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final langSettingsController = Get.find<LangSettingsController>();
    var langTag = langSettingsController.langSettings.lang.split('-')[0];
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Theme.of(context).colorScheme.surfaceVariant
                  : Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              'Menu'.tr,
              style: TextStyle(color: isDarkMode
                  ? Theme.of(context).colorScheme.onSurfaceVariant
                  : Theme.of(context).colorScheme.onPrimary,),
            ),
          ),
          ListTile(
            title:  Text('Theme settings'.tr),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.THEME_SETTINGS_SCREEN);
            },
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            title:  Text('${'Language'.tr}:'),
            subtitle: Text(LanguageList.getDisplayLanguage(langTag).tr),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.LANG_SETTINGS_SCREEN);
            },
            trailing: const Icon(Icons.chevron_right),
          )
        ],
      ),
    );
  }
}
