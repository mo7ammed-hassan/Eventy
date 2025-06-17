import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final double? width, height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double radius;
  final bool showBorder;
  final Widget? child;
  final Color borderColor;

  const RoundedContainer({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.backgroundColor = AppColors.white,
    this.radius = AppSizes.eventCardRadius,
    this.showBorder = false,
    this.child,
    this.borderColor = AppColors.grey,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkerGrey : AppColors.confirmLocationColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
