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
    final cubit = context.read<OnboardingCubit>();

    return Positioned(
      top: DeviceUtils.getAppBarHeight(),
      right: AppSizes.defaultPadding,
      child: BlocBuilder<OnboardingCubit, int>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          final shouldShowSkip = !cubit.isLastPage;

          return shouldShowSkip
              ? TextButton(
                  onPressed: cubit.skipPage,
                  child: Text(
                    AppStrings.skip,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
