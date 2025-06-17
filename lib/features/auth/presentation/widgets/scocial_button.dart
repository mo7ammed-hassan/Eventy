import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';

class TSocialButton extends StatelessWidget {
  final String socialIcon;
  final void Function()? onPressed;
  const TSocialButton({super.key, required this.socialIcon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Image(
          width: AppSizes.iconLg,
          height: AppSizes.iconLg,
          image: AssetImage(socialIcon),
        ),
      ),
    );
  }
}
