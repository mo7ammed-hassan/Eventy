import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class BottomNavBarPlusIcon extends StatelessWidget {
  const BottomNavBarPlusIcon({super.key, this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return Positioned(
      top: -28,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: ShapeDecoration(
            color: isDark ? AppColors.mainblackColor : Colors.white,
            shape: const CircleBorder(),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.plushIconGradient,
            ),
            child: Center(
              child: SvgPicture.asset(
                AppImages.darkPlusIcon,
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                  isDark ? Colors.black : Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
