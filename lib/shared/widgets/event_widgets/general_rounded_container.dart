import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/app_styles.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class GeneralRoundedContainer extends StatelessWidget {
  const GeneralRoundedContainer({
    super.key,
    this.child,
    this.radius,
    this.padding,
  });
  final Widget? child;
  final double? radius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: isDark ? AppColors.dark : Colors.white,
        borderRadius: BorderRadius.circular(radius ?? AppSizes.eventCardRadius),
        boxShadow: AppStyles.eventCardShadow(isDark),
      ),
      child: child,
    );
  }
}
