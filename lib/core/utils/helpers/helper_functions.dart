import 'dart:math';

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
}
