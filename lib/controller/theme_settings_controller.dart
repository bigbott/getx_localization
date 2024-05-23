

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_localization/model/theme_settings.dart';
import 'package:getx_localization/service/theme_settings/theme_settings_service.dart';
import 'package:getx_localization/view/theme_builder.dart';

class ThemeSettingsController extends GetxController {
  
  final ThemeSettingsService themeSettingsService;

  var themeSettings = ThemeSettings();

  ThemeSettingsController({required this.themeSettingsService,});


  @override
  void onInit() async{
    themeSettings =  themeSettingsService.loadSettings();
    super.onInit();
  }    

  void setMode(String mode) {
    themeSettings.mode = mode;
    themeSettingsService.saveSettings(themeSettings);
    _changeTheme();
    update();
  }

  void setTheme(String theme) {
    themeSettings.theme = theme;
    themeSettingsService.saveSettings(themeSettings);
    _changeTheme();
    update();
  }

  void setTransparentAppbar(bool val) {
    themeSettings.transparentAppbar = val;
    themeSettingsService.saveSettings(themeSettings);
    _changeTheme();
    update();
  }

  void _changeTheme() {
      ThemeData themeData = themeSettings.mode == 'light' 
      ?  ThemeBuilder().buildLightTheme(themeSettings.theme, themeSettings.transparentAppbar)
      :  ThemeBuilder().buildDarkTheme(themeSettings.theme, themeSettings.transparentAppbar);
      Get.changeTheme(themeData);
  }
}