import 'package:eventy/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/auth/presentation/widgets/scocial_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TSocialButtons extends StatelessWidget {
  const TSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TSocialButton(
          onPressed: () => context.read<SignInCubit>().signinWithGoogle(),
          socialIcon: AppImages.google,
        ),
        const SizedBox(width: AppSizes.spaceBtwItems),
        const TSocialButton(socialIcon: AppImages.facebook),
      ],
    );
  }

  // _navigateToMenuPage(BuildContext context) {
  //   context.removeAll(const NavigationMenu());
  // }
}
