import 'package:eventy/config/routing/routes.dart';
import 'package:eventy/features/onboarding/cubits/onboarding_cubit.dart';
import 'package:eventy/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:eventy/features/onboarding/widgets/onbboarding_page_view.dart';
import 'package:eventy/features/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:eventy/features/onboarding/widgets/onboarding_next_button.dart';
import 'package:eventy/features/onboarding/widgets/onboarding_skip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: BlocListener<OnboardingCubit, int>(
        listener: (context, state) {
          if (state == 3) {
            context.pushNamedAndRemoveUntilPage(Routes.loginScreen);
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              // -- Onboarding View
              const OnboardingPageView(),
              // -- Onboarding Skip
              const OnBoardingSkip(),
              // -- Onboarding Dots
              const OnBoardingDotNavigation(),
              // -- Onboarding Next
              const OnBoardingNextButton(),
            ],
          ),
        ),
      ),
    );
  }
}
