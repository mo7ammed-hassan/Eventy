import 'dart:math';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/enums/enums.dart';
import 'package:flutter/material.dart';


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
}
