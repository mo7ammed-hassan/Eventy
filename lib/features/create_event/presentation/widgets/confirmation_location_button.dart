import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eventy/config/routing/routes.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/utils/helpers/extensions/navigation_extension.dart';

class ConfirmationLocationButton extends StatelessWidget {
  const ConfirmationLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          backgroundColor: isDark
              ? const Color.fromARGB(255, 56, 55, 55)
              : AppColors.confirmLocationColor,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
        onPressed: () => context.pushNamedPage(Routes.mapScreen),
        icon: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: FittedBox(
            child: SvgPicture.asset(
              AppImages.locationPin,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        label: FittedBox(
          child: Text(
            'Tap to choose a location',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white : AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
