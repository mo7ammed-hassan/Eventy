import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_colors.dart';

class CustomAppbarTheme {
  CustomAppbarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 2,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    iconTheme: IconThemeData(color: AppColors.secondaryColor, size: 22),
    actionsIconTheme: IconThemeData(
      color: AppColors.primaryTextColor,
      size: 22,
    ),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  static const darkAppBarTheme = AppBarTheme(
    elevation: 2,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.black,
    surfaceTintColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white, size: 22),toolbarHeight: 50,
    actionsIconTheme: IconThemeData(color: Colors.white, size: 22),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );
}
