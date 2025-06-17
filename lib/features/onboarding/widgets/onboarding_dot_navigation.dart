import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/cubits/onboarding/onboarding_cubit.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);
    final cubit = context.read<OnboardingCubit>();

    return Positioned(
      bottom: DeviceUtils.getBottomNavigationBarHeight() + 18,
      left: AppSizes.defaultScreenPadding,
      right: AppSizes.defaultScreenPadding,
      child: SmoothPageIndicator(
        controller: cubit.pageController,
        count: 3,
        onDotClicked: cubit.dotNavigationClick,
        effect: ExpandingDotsEffect(
          paintStyle: PaintingStyle.fill,
          activeDotColor: isDarkMode
              ? AppColors.light
              : AppColors.secondaryColor,
          dotHeight: 4,
          dotWidth: 14.0,
        ),
      ),
    );
  }
}
