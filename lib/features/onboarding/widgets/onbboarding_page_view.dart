import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/text_strings.dart';
import 'package:eventy/core/cubits/onboarding/onboarding_cubit.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    return BlocBuilder<OnboardingCubit, int>(
      builder: (context, state) {
        return PageView(
          controller: cubit.pageController,
          onPageChanged: cubit.updatePageIndicator,
          children: [
            // -- Page 1
            _OnboardingPage(
              imagePath: AppImages.onboarding1,
              title: AppStrings.onBoardingSubTitle1,
            ),
            // -- Page 2
            _OnboardingPage(
              imagePath: AppImages.onboarding2,
              title: AppStrings.onBoardingSubTitle2,
            ),
            // -- Page 3
            _OnboardingPage(
              imagePath: AppImages.onboarding3,
              title: AppStrings.onBoardingTitle3,
            ),
          ],
        );
      },
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.imagePath, required this.title});
  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
      child: SizedBox(
        width: double.infinity,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // -- Page Image
              Flexible(child: Image(image: AssetImage(imagePath))),

              // -- Page Content
              SizedBox(height: DeviceUtils.screenHeight(context) * 0.12),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
