import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:eventy/config/routing/routes.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/cubits/password_and_selection/password_and_selection_cubit.dart';
import 'package:eventy/core/cubits/password_and_selection/password_and_selection_state.dart';
import 'package:eventy/core/widgets/popups/full_screen_loader.dart'
    show TFullScreenLoader;
import 'package:eventy/core/widgets/popups/loaders.dart';
import 'package:eventy/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:eventy/features/auth/presentation/cubits/signin_cubit/signin_state.dart';
import 'package:eventy/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:eventy/core/utils/validators/validation.dart';
import 'package:eventy/core/widgets/checkbox/custom_checkbox.dart';
import 'package:eventy/features/auth/presentation/widgets/password_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordAndSelectionCubit(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultScreenPadding,
        ),
        child: Form(
          key: context.read<SignInCubit>().formKey,
          //autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              _emailField(context),
              const SizedBox(height: AppSizes.spaceBtwTextField),
              PasswordField(
                controller: context.read<SignInCubit>().passwordController,
                applyValidator: false,
              ),
              const SizedBox(height: AppSizes.spaceBtwTextField / 2),
              // Remember Me & Forget Password
              _rememberMeAndForgetPassword(context),
              const SizedBox(height: AppSizes.spaceBtwSections),
              _signIn(context),
              const SizedBox(height: AppSizes.spaceBtwItems),
              _createAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _emailField(BuildContext context) {
    return TextFormField(
      controller: context.read<SignInCubit>().emailController,
      validator: (value) => TValidator.validateEmail(value),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Iconsax.direct_right),
      ),
    );
  }

  Widget _rememberMeAndForgetPassword(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            BlocBuilder<PasswordAndSelectionCubit, PasswordAndSelectionState>(
              builder: (context, state) {
                return CustomCheckbox(
                  value: state.isRememberMe,
                  onChanged: (value) => context
                      .read<PasswordAndSelectionCubit>()
                      .toggleRememberMe(),
                );
              },
            ),
            const SizedBox(width: 5),
            const Text('Remember me'),
          ],
        ),
        TextButton(
          onPressed: () => context.pushNamedPage(Routes.forgetPasswordScreen),
          child: const Text(
            'Forget Password',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _signIn(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          FocusManager.instance.primaryFocus?.unfocus();
          TFullScreenLoader.stopLoading();
          Loaders.errorSnackBar(title: 'Error', message: state.message);
        } else if (state is SignInLoading) {
          FocusManager.instance.primaryFocus?.unfocus();
          TFullScreenLoader.openLoadingDialog(
            'Logging you in...',
            AppImages.docerAnimation,
          );
        } else if (state is SignInSuccess) {
          // close keyboard
          FocusManager.instance.primaryFocus?.unfocus();
          TFullScreenLoader.stopLoading();
          _navigateToMenuPage(context);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              var isRememberMe = context
                  .read<PasswordAndSelectionCubit>()
                  .state
                  .isRememberMe;
              // Login
              await context.read<SignInCubit>().signInWithEmailAndPassword(
                isRememberMe,
              );
            },
            child: const Text('Sign In'),
          ),
        );
      },
    );
  }

  SizedBox _createAccount(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => context.pushNamedPage(Routes.signupScreen),

        child: const Text('Create Account'),
      ),
    );
  }

  void _navigateToMenuPage(BuildContext context) {
    context.pushNamedAndRemoveUntilPage(Routes.navigationScreen);
  }
}
