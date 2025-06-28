import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:eventy/config/routing/routes.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/cubits/password_and_selection/password_and_selection_cubit.dart';
import 'package:eventy/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:eventy/core/widgets/popups/full_screen_loader.dart';
import 'package:eventy/core/widgets/popups/loaders.dart';
import 'package:eventy/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:eventy/features/auth/presentation/cubits/signup_cubit/signup_state.dart';
import 'package:eventy/core/utils/validators/validation.dart';
import 'package:eventy/features/auth/presentation/widgets/password_field.dart';
import 'package:eventy/features/auth/presentation/widgets/term_and_condation_checkbox.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordAndSelectionCubit(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultScreenPadding,
        ),
        child: AutofillGroup(
          child: Form(
            key: context.read<SignupCubit>().formKey,
            //autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                _nameField(context),
                const SizedBox(height: AppSizes.spaceBtwTextField),
                _emailField(context),
                const SizedBox(height: AppSizes.spaceBtwTextField),
                PasswordField(
                  controller: context.read<SignupCubit>().passwordController,
                ),
                const SizedBox(height: AppSizes.spaceBtwTextField),
                PasswordField(
                  passwordField: false,
                  labelText: 'Confirm Password',
                  controller: context
                      .read<SignupCubit>()
                      .confirmPasswordController,
                ),
                const SizedBox(height: 26.0),
                const TTermAndCondationCheckbox(),
                const SizedBox(height: 32.0),
                _createAccount(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _nameField(BuildContext context) {
    return TextFormField(
      controller: context.read<SignupCubit>().nameController,
      validator: (value) => TValidator.validateEmptyText('Name', value),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      autofillHints: const [AutofillHints.name],
      decoration: const InputDecoration(
        labelText: 'Username',
        prefixIcon: Icon(Iconsax.direct),
      ),
    );
  }

  TextFormField _emailField(BuildContext context) {
    return TextFormField(
      key: const Key('email'),
      controller: context.read<SignupCubit>().emailController,
      validator: (value) => TValidator.validateEmail(value),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      decoration: const InputDecoration(
        labelText: 'E-Mail',
        prefixIcon: Icon(Iconsax.direct),
      ),
    );
  }

  SizedBox _createAccount(BuildContext context) {
    return SizedBox(
      key: Key('Create Account'),
      width: double.infinity,
      child: BlocListener<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is PrivacyValidationErrorState) {
            FocusManager.instance.primaryFocus?.unfocus();
            Loaders.warningSnackBar(
              title: 'Accept Privacy Policy',
              message: state.errorMessage,
            );
          } else if (state is PasswordValidationErrorState) {
            FocusManager.instance.primaryFocus?.unfocus();
            Loaders.warningSnackBar(
              title: 'wrong password',
              message: state.errorMessage,
            );
          } else if (state is SignupLoadingState) {
            FocusManager.instance.primaryFocus?.unfocus();
            TFullScreenLoader.openLoadingDialog(
              'We are processing your information...',
              AppImages.docerAnimation,
            );
          } else if (state is SignupErrorState) {
            TFullScreenLoader.stopLoading();
            Loaders.errorSnackBar(title: 'Error', message: state.message);
          } else if (state is SignupSuccessState) {
            FocusManager.instance.primaryFocus?.unfocus();
            TFullScreenLoader.stopLoading();
            _navigateToVerifyEmail(
              context,
              context.read<SignupCubit>().emailController.text.trim(),
            );
            Loaders.successSnackBar(
              title: 'Verify your email',
              message: 'Please check your email to verify your account',
            );
          }
        },
        child: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () {
                var isPrivacyAccepted = context
                    .read<PasswordAndSelectionCubit>()
                    .state
                    .isPrivacyAccepted;
                context.read<SignupCubit>().signup(isPrivacyAccepted);
              },
              child: const Text('Create Account'),
            );
          },
        ),
      ),
    );
  }

  void _navigateToVerifyEmail(BuildContext context, email) {
    context.pushNamedAndRemoveUntilPage(
      Routes.otpVerificationScreen,
      arguments: email,
    );
  }
}
