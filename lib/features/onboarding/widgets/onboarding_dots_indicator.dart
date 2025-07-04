import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/features/onboarding/cubits/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingDotsIndicator extends StatelessWidget {
  const OnboardingDotsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    final isDark = HelperFunctions.isDarkMode(context);

    return BlocBuilder<OnboardingCubit, int>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, currentIndex) {
        return Positioned(
          bottom: DeviceUtils.getBottomNavigationBarHeight() + 18,
          left: AppSizes.defaultScreenPadding,
          right: AppSizes.defaultScreenPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(cubit.onboardingPages.length, (index) {
              final isActive = index == currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 3,
                width: isActive ? 35 : 15,
                decoration: BoxDecoration(
                  color: isActive
                      ? (isDark ? AppColors.light : AppColors.secondaryColor)
                      : AppColors.inactiveIconColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
