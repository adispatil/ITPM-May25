import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizationController extends GetxController {
  var currentLocale = const Locale('en', 'US').obs;
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with English
    changeLocale(const Locale('en', 'US'));
  }

  void changeLocale(Locale locale) {
    currentLocale.value = locale;
    Get.updateLocale(locale);
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  String getCurrentLanguageName() {
    switch (currentLocale.value.languageCode) {
      case 'en':
        return 'English';
      case 'hi':
        return 'हिंदी';
      default:
        return 'English';
    }
  }

  String getCurrentLanguageCode() {
    return currentLocale.value.languageCode;
  }
} 