import 'dart:math';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/enums/enums.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class HelperFunctions {
  const HelperFunctions._();

  static bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  /// --- Random Color Generator --- ///
  static List<Color> randomColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.blueGrey,
    Colors.purple,
    Colors.pink,
  ];

  static Color randomColorGenerator() =>
      randomColors[Random().nextInt(randomColors.length)];

  static bool isCurrentScreen(BuildContext context) {
    return ModalRoute.of(context)?.isCurrent ?? true;

    // if (!isCurrentScreen) {
    //   Future.delayed(Duration(seconds: 1), () {
    //     return const SizedBox.shrink();
    //   });
    // }
  }

  static Color getColor(StepStatus status, BuildContext context) {
    switch (status) {
      case StepStatus.completed:
        return const Color.fromARGB(255, 11, 79, 139);
      case StepStatus.inProgress:
        return AppColors.secondaryColor;
      case StepStatus.pending:
        return isDarkMode(context) ? AppColors.dark : Color(0xFFbfbfc1);
    }
  }

  static IconData getIcon(StepStatus status) {
    switch (status) {
      case StepStatus.completed:
        return Icons.check;
      case StepStatus.inProgress:
        return Icons.lock_open;
      case StepStatus.pending:
        return Icons.lock_outline;
    }
  }

  static InputDecoration buildFieldDecoration(isDark, {String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 12),
      filled: true,
      fillColor: isDark ? AppColors.dark : AppColors.dateFieldColor,
      contentPadding: EdgeInsets.all(16.0),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: isDark ? AppColors.darkerGrey : AppColors.confirmLocationColor,
        ),
        borderRadius: BorderRadius.circular(AppSizes.dateFieldRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: isDark ? AppColors.darkerGrey : AppColors.confirmLocationColor,
        ),
        borderRadius: BorderRadius.circular(AppSizes.dateFieldRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: isDark ? AppColors.darkerGrey : AppColors.confirmLocationColor,
        ),
        borderRadius: BorderRadius.circular(AppSizes.dateFieldRadius),
      ),
    );
  }

  static Future<String> getFullAddress(LocationEntity location) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      ).timeout(const Duration(seconds: 3));

      if (placemarks.isEmpty) return 'Unknown location';

      final address = placemarks.first;
      final parts = [
        address.street,
        address.subAdministrativeArea,
        address.country,
      ].where((part) => part?.isNotEmpty ?? false);

      return parts.isNotEmpty ? parts.join(', ') : 'Unknown location';
    } catch (e) {
      return 'Location: ${location.latitude.toStringAsFixed(4)}, '
          '${location.longitude.toStringAsFixed(4)}';
    }
  }
}
