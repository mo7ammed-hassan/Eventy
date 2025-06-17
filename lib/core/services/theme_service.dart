import 'package:eventy/core/storage/app_storage.dart';
import 'package:flutter/material.dart';

class ThemeService {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.system,
  );

  static Future<void> init() async {
    final isDark = AppStorage.getBool('isDarkMode');
    if (isDark != null) {
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
    AppStorage.setValue('isDarkMode', mode == ThemeMode.dark);
    themeNotifier.value = mode;
  }

  static bool get isDark => themeNotifier.value == ThemeMode.dark;
}
