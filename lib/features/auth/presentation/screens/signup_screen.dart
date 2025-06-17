import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventy/config/routing/routes.dart';
import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:eventy/features/auth/presentation/widgets/form_divider.dart';
import 'package:eventy/features/auth/presentation/widgets/signup/sign_up_form.dart';
import 'package:eventy/features/auth/presentation/widgets/social_buttons.dart';
import 'package:eventy/shared/widgets/auth/auth_header.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<SignupCubit>(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header // Image
              const AuthHeader(imagePath: AppImages.signUpImage),
              // Logo
              Image.asset(AppImages.appLogo, width: 140),
              const SizedBox(height: 40),
              // Login Form
              const SignupForm(),
              const SizedBox(height: AppSizes.spaceBtwSections),
              // Divider
              const TFormDivider(dividerText: 'or Sign in with'),
              const SizedBox(height: 32.0),
              // Social Buttons
              const TSocialButtons(),
              const SizedBox(height: 32.0),
              // Footer
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Login',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            Navigator.pushNamed(context, Routes.loginScreen),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: kToolbarHeight),
            ],
          ),
        ),
      ),
    );
  }
}
