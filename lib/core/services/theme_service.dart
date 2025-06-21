import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/storage/app_storage.dart';
import 'package:flutter/material.dart';

class ThemeService {
  static final appStorage = getIt<AppStorage>();
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.system,
  );

  static Future<void> init() async {
    final isDark = appStorage.getBool('isDarkMode');
    if (isDark) {
      themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
    } else {
      themeNotifier.value = ThemeMode.system;
    }
  }

  static void toggleTheme() {
    final isDark = themeNotifier.value == ThemeMode.dark;
    setTheme(isDark ? ThemeMode.light : ThemeMode.dark);
  }

  static void setTheme(ThemeMode mode) {
    appStorage.setBool('isDarkMode', mode == ThemeMode.dark);
    themeNotifier.value = mode;
  }

  static bool get isDark => themeNotifier.value == ThemeMode.dark;
}
