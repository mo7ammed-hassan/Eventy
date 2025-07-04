import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/onboarding/cubits/onboarding_cubit.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/features/onboarding/models/onboarding_page_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return BlocBuilder<OnboardingCubit, int>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return PageView.builder(
          controller: cubit.pageController,
          onPageChanged: cubit.changePage,
          itemCount: cubit.totalPages,
          itemBuilder: (context, index) {
            final pageData = cubit.onboardingPages[index];
            return _OnboardingPage(onbboardingPageData: pageData);
          },
        );
      },
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.onbboardingPageData});

  final OnbboardingPageData onbboardingPageData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = DeviceUtils.screenHeight(context);

    return Padding(
      padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // -- Page Image
          Flexible(child: Image.asset(onbboardingPageData.imagePath)),

          SizedBox(height: screenHeight * 0.12),

          // -- Title Text
          Text(
            onbboardingPageData.title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
