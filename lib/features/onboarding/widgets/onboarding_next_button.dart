import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/onboarding/cubits/onboarding_cubit.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    final isDark = HelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: DeviceUtils.getBottomNavigationBarHeight() / 1.2,
      right: AppSizes.defaultScreenPadding,
      child: ElevatedButton(
        onPressed: cubit.nextPage,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(14),
          backgroundColor: isDark
              ? AppColors.secondaryColor
              : AppColors.primaryColor,
          elevation: 4,
          shadowColor: Colors.black26,
        ),
        child: const Icon(Iconsax.arrow_right_3, color: AppColors.white),
      ),
    );
  }
}
