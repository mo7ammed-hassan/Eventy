import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/helpers/app_context.dart';

class Loaders {
  static void hideSnackBar() =>
      ScaffoldMessenger.of(AppContext.context).hideCurrentSnackBar();

  static void customToast({
    required String message,
    bool isMedium = true,
    int duration = 600,
  }) {
    ScaffoldMessenger.of(AppContext.context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        duration: Duration(milliseconds: duration),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(AppContext.context).brightness == Brightness.dark
                ? AppColors.darkerGrey.withValues(alpha: 0.9)
                : AppColors.grey.withValues(alpha: 0.9),
          ),
          child: Center(
            child: Text(
              message,
              style: isMedium
                  ? Theme.of(AppContext.context).textTheme.bodyMedium
                  : Theme.of(AppContext.context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  static void successSnackBar({
    required String title,
    String message = '',
    int duration = 3,
    Color? backgroundColor,
  }) {
    _showSnackBar(
      title: title,
      message: message,
      backgroundColor: backgroundColor ?? Colors.green,
      icon: const Icon(Iconsax.check, color: Colors.white),
      duration: duration,
    );
  }

  static void warningSnackBar({required String title, String message = ''}) {
    _showSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.orange,
      icon: const Icon(Iconsax.warning_2, color: Colors.white),
    );
  }

  static void errorSnackBar({required String title, String message = ''}) {
    _showSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.red.shade600,
      icon: const Icon(Iconsax.warning_2, color: Colors.white),
    );
  }

  static void _showSnackBar({
    required String title,
    required String message,
    required Color backgroundColor,
    required Icon icon,
    int duration = 3,
  }) {
    ScaffoldMessenger.of(AppContext.context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(message, style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
      ),
    );
  }
}
