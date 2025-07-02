import 'package:eventy/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTimePickerTheme {
  const CustomTimePickerTheme._();

  static final TimePickerThemeData lightTimePickerTheme = TimePickerThemeData(
    backgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.all(0),
      fillColor: AppColors.dateFieldColor,
      filled: true,
    ),
    dialBackgroundColor: AppColors.dateFieldColor,
    cancelButtonStyle: TextButton.styleFrom(
      textStyle: const TextStyle(color: Colors.blueGrey),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),

    confirmButtonStyle: TextButton.styleFrom(
      backgroundColor: AppColors.dateFieldColor,
      textStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),

    hourMinuteColor: WidgetStateColor.resolveWith(
      (states) =>
          states.contains(WidgetState.selected) ? Colors.teal : Colors.white,
    ),
    hourMinuteTextColor: WidgetStateColor.resolveWith(
      (states) =>
          states.contains(WidgetState.selected) ? Colors.white : Colors.teal,
    ),
    dayPeriodTextColor: WidgetStateColor.resolveWith(
      (states) =>
          states.contains(WidgetState.selected) ? Colors.white : Colors.teal,
    ),
    dayPeriodColor: WidgetStateColor.resolveWith(
      (states) =>
          states.contains(WidgetState.selected) ? Colors.teal : Colors.white,
    ),
    dialHandColor: Colors.teal,
  );

  static final TimePickerThemeData darkTimePickerTheme = TimePickerThemeData(
    dayPeriodBorderSide: const BorderSide(
      color: AppColors.darkerGrey,
      width: 1,
    ),
    backgroundColor: AppColors.black,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.all(0),
      fillColor: AppColors.dark,
      filled: true,
    ),

    cancelButtonStyle: TextButton.styleFrom(
      textStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    confirmButtonStyle: TextButton.styleFrom(
      backgroundColor: AppColors.dark,
      textStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    hourMinuteColor: WidgetStateColor.resolveWith(
      (states) =>
          states.contains(WidgetState.selected) ? Colors.teal : AppColors.dark,
    ),
    hourMinuteTextColor: WidgetStateColor.resolveWith(
      (states) =>
          states.contains(WidgetState.selected) ? Colors.white : Colors.teal,
    ),
    dayPeriodTextColor: WidgetStateColor.resolveWith(
      (states) =>
          states.contains(WidgetState.selected) ? Colors.white : Colors.teal,
    ),
    dayPeriodColor: WidgetStateColor.resolveWith(
      (states) =>
          states.contains(WidgetState.selected) ? Colors.teal : AppColors.dark,
    ),
    dialBackgroundColor: AppColors.darkerGrey.withValues(alpha: 0.5),
    hourMinuteShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    dayPeriodShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    dialHandColor: Colors.teal,
  );
}
