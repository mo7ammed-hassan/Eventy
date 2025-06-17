import 'package:eventy/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class AppStyles {
  const AppStyles._();

  static List<BoxShadow> eventCardShadow(bool isDark) => <BoxShadow>[
    BoxShadow(
      color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
      offset: const Offset(0, 1),
      blurRadius: 4.0,
    ),
  ];

  static const eventCardRadius = BorderRadius.only(
    topLeft: Radius.circular(AppSizes.eventCardRadius),
    topRight: Radius.circular(AppSizes.eventCardRadius),
  );
}
