import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:eventy/features/auth/presentation/widgets/form_divider.dart';
import 'package:eventy/features/auth/presentation/widgets/login/login_form.dart';
import 'package:eventy/features/auth/presentation/widgets/social_buttons.dart';
import 'package:eventy/shared/widgets/auth/auth_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<SignInCubit>(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              const AuthHeader(imagePath: AppImages.loginImage),
              // Logo
              Image.asset(AppImages.appLogo, width: 140),
              const SizedBox(height: 40),
              // Login Form
              const LoginForm(),
              const SizedBox(height: AppSizes.spaceBtwSections),
              const TFormDivider(dividerText: 'or Sign in with'),
              const SizedBox(height: 32.0),
              // Footer
              const TSocialButtons(enableSignin: true),
            ],
          ),
        ),
      ),
    );
  }
}
