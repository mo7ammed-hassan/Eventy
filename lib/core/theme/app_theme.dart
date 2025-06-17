import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/theme/custom_themes/custom_text_theme.dart';
import 'package:eventy/core/theme/custom_themes/custom_appbar_theme.dart';
import 'package:eventy/core/theme/custom_themes/eleveted_button_theme.dart';
import 'package:eventy/core/theme/custom_themes/custom_outlined_button_teme.dart';
import 'package:eventy/core/theme/custom_themes/custom_input_decoration_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primaryColorLight: Colors.white,
    textTheme: CustomTextTheme.lightTextTheme,
    elevatedButtonTheme: CustomElevetedButtonTheme.lightElevetedButtonTheme,
    appBarTheme: CustomAppbarTheme.lightAppBarTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: CustomInputDecorationTheme.lightInputDecorationTheme,
    navigationBarTheme: NavigationBarThemeData(
      iconTheme: const WidgetStatePropertyAll(
        IconThemeData(color: Color.fromARGB(255, 110, 126, 155)),
      ),
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: const FadeUpwardsPageTransitionsBuilder(),
      },
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF90A4AE),
    scaffoldBackgroundColor: AppColors.black,
    textTheme: CustomTextTheme.darkTextTheme,
    elevatedButtonTheme: CustomElevetedButtonTheme.darkElevetedButtonTheme,
    appBarTheme: CustomAppbarTheme.darkAppBarTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: CustomInputDecorationTheme.darkInputDecorationTheme,
    primaryColorDark: Colors.black,

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.black,

      indicatorColor: AppColors.activeIconColor.withValues(alpha: 0.6),
      iconTheme: const WidgetStatePropertyAll(
        IconThemeData(color: Colors.white),
      ),
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: const FadeUpwardsPageTransitionsBuilder(),
      },
    ),
  );
}
