import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:getx_localization/common/hive.dart';
import 'package:getx_localization/controller/lang_settings_controller.dart';
import 'package:getx_localization/controller/theme_settings_controller.dart';
import 'package:getx_localization/routes.dart';
import 'package:getx_localization/service/lang_settings/hive_lang_settings_service.dart';
import 'package:getx_localization/service/theme_settings/hive_theme_settings_service.dart';
import 'package:getx_localization/view/home_screen.dart';
import 'package:getx_localization/view/theme_builder.dart';

void main() async {
  await initHive();
  Get.put(ThemeSettingsController(
    themeSettingsService: HiveThemeSettingsService(),
  ));
   print(DateTime.now().millisecondsSinceEpoch);
  await HiveLangSettingsService().init();
    print(DateTime.now().millisecondsSinceEpoch);
  Get.put(LangSettingsController(
    langSettingsService: HiveLangSettingsService(),
  ));


  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeSettingsController>();
    String theme = themeController.themeSettings.theme;
    String mode = themeController.themeSettings.mode;
    bool transparentAppbar = themeController.themeSettings.transparentAppbar;
    final langController = Get.find<LangSettingsController>();

   // return GetBuilder<LangSettingsController>(builder: (langController) {
      return GetMaterialApp(
        theme: ThemeBuilder().buildLightTheme(theme, transparentAppbar),
        darkTheme: ThemeBuilder().buildDarkTheme(theme, transparentAppbar),
        themeMode: ThemeBuilder().getThemeMode(mode),
        home: const HomeScreen(),
        initialRoute: Routes.HOME_SCREEN,
        getPages: Routes.routes,
        translations: langController.messages, // Your translations
        locale: langController
            .tagToLocale(langController.langSettings.lang), // Default language
        fallbackLocale:
            const Locale('ru', 'RU'), // Fallback language in case of failure
        supportedLocales:
            langController.tagsToLocales(langController.supportedLangs),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        debugShowCheckedModeBanner: false,
      );
    
  }
}
