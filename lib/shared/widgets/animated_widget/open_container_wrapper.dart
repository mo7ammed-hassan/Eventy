import 'package:animations/animations.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    super.key,
    required this.child,
    required this.nextScreen,
    required this.radius,
    this.closedElevation = 0.5,
  });
  final Widget child;
  final Widget nextScreen;
  final Radius radius;
  final double closedElevation;
  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return ClipRect(
      child: OpenContainer(
        closedElevation: closedElevation,
        closedShape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(radius),
        ),
        closedColor: isDark ? Colors.transparent : AppColors.white,
        transitionDuration: const Duration(milliseconds: 800), //850
        closedBuilder: (_, VoidCallback openContainer) {
          return InkWell(onTap: openContainer, child: child);
        },
        openBuilder: (_, __) => nextScreen,
      ),
    );
  }
}
