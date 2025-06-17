import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventy/config/routing/routes.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/text_strings.dart';
import 'package:eventy/core/cubits/password_and_selection/password_and_selection_cubit.dart';
import 'package:eventy/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:eventy/core/widgets/popups/full_screen_loader.dart';
import 'package:eventy/core/widgets/popups/loaders.dart';
import 'package:eventy/features/auth/presentation/cubits/forget_password/reset_password_cubit.dart';
import 'package:eventy/features/auth/presentation/cubits/forget_password/reset_password_state.dart';
import 'package:eventy/features/auth/presentation/widgets/password_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)?.settings.arguments as String;
    context.read<ResetPasswordCubit>().emailController.text = email;
    return BlocProvider(
      create: (context) => PasswordAndSelectionCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultScreenPadding),
            child: Form(
              key: context.read<ResetPasswordCubit>().formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kToolbarHeight),
                  Text(
                    'Reset Password',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  Text(
                    'Please enter your new password for\n$email',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  // _emailField(context),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  PasswordField(
                    controller: context
                        .read<ResetPasswordCubit>()
                        .passwordController,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  PasswordField(
                    passwordField: false,
                    labelText: 'Confirm Password',
                    controller: context
                        .read<ResetPasswordCubit>()
                        .confPasswordController,
                  ),
                  const SizedBox(height: 32.0),
                  _submitButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordLoadingState) {
          TFullScreenLoader.openLoadingDialog(
            'We are processing your information...',
            AppImages.docerAnimation,
          );
        } else if (state is ResetPasswordSuccessState) {
          TFullScreenLoader.stopLoading();
          Loaders.successSnackBar(
            title: 'Success',
            message: state.successMessage,
          );
          context.pushNamedAndRemoveUntilPage(Routes.loginScreen);
        } else if (state is ResetPasswordErrorState) {
          TFullScreenLoader.stopLoading();
          Loaders.errorSnackBar(title: 'Error', message: state.errorMessage);
        } else if (state is ResetPasswordValidationErrorState) {
          Loaders.warningSnackBar(
            title: 'Wrong Password',
            message: state.errorMessage,
          );
        }
      },
      builder: (context, state) => state is CheckEmailLoadingState
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await context.read<ResetPasswordCubit>().resetPassword();
                },
                child: const Text(AppStrings.submit),
              ),
            ),
    );
  }
}
