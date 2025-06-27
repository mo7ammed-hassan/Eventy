import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/helpers/app_context.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

class CustomDialogs {
  CustomDialogs._();

  Future<void> showCustomDialog() async {}

  static Future<bool?> showConfirmationDialog({
    String? title,
    String? message,
    String? buttonText,
    String? confirmButtonText,
    TextDirection? textDirection,
    IconData? iconData,
    Color? iconColor,
  }) async {
    final isDark = HelperFunctions.isDarkMode(AppContext.overlayContext);
    return showDialog(
      context: AppContext.overlayContext,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.mainblackColor : AppColors.white,
        icon: Icon(
          iconData ?? Iconsax.logout,
          size: 40,
          color: iconColor ?? Colors.red,
        ),
        content: Text(
          title ?? 'Are you sure you want to logout?',
          textDirection: textDirection,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              buttonText ?? 'Cancel',
              textDirection: textDirection,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              confirmButtonText ?? 'Logout',
              textDirection: textDirection,
              style: TextStyle(
                color: iconColor ?? Colors.red,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<bool?> showLocationDialog() async {
    final isDark = HelperFunctions.isDarkMode(AppContext.overlayContext);
    return showDialog(
      context: AppContext.overlayContext,
      builder: (context) => Container(
        color: isDark ? AppColors.mainblackColor : AppColors.white,
        child: Column(
          children: [
            // -- Location Image -- //
            Image.asset('assets/images/location.png'),
          ],
        ),
      ),
    );
  }
}
