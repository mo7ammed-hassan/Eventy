import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A service class to manage system UI settings such as status bar and navigation bar colors.
/// This class provides a static method to set the status bar color and icon brightness based on the theme.
/// It uses the [SystemChrome] class from the Flutter framework to customize the system UI overlay styles.
/// The `setStatusBarColor` method takes a [BuildContext] as a parameter to determine the current theme (dark or light)
/// and applies the appropriate colors and brightness settings.
/// This service is useful for ensuring that the system UI elements match the app's theme,
class SystemUiService {
  static void setSystemUIOverlayStyle(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    /// Set the status bar color and icon brightness based on the theme
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        /// Set status bar brightness
        // Set status bar color
        statusBarColor: isDark ? AppColors.mainblackColor : Colors.white,
        // Set status bar icon brightness
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,

        /// Set system navigation bar color
        // Set navigation bar color
        systemNavigationBarColor: isDark
            ? AppColors.mainblackColor
            : Colors.white,
        // Set navigation bar icon brightness
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
      ),
    );
  }
}
