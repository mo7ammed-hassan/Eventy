import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/text_strings.dart';
import 'package:eventy/features/onboarding/cubits/onboarding_cubit.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: DeviceUtils.getAppBarHeight(),
      right: AppSizes.defaultPadding,
      child: TextButton(
        onPressed: () {
          context.read<OnboardingCubit>().skipPage();
        },
        child: BlocBuilder<OnboardingCubit, int>(
          builder: (context, state) {
            return state <= 2
                ? const SizedBox.shrink()
                : Text(
                    AppStrings.skip,
                    style: Theme.of(context).textTheme.bodyLarge,
                  );
          },
        ),
      ),
    );
  }
}
