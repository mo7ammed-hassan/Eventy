import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/text_strings.dart';
import 'package:eventy/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:eventy/core/utils/validators/validation.dart';
import 'package:eventy/core/widgets/popups/loaders.dart';
import 'package:eventy/features/auth/presentation/cubits/forget_password/reset_password_cubit.dart';
import 'package:eventy/features/auth/presentation/cubits/forget_password/reset_password_state.dart';
import 'package:eventy/features/auth/presentation/screens/otp_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.clear),
            onPressed: () => context.popPage(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultScreenPadding),
          child: Form(
            key: context.read<ResetPasswordCubit>().formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.forgetPassword,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Text(
                  AppStrings.forgetPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: AppSizes.spaceBtwSections * 2),
                _emailField(context),
                const SizedBox(height: AppSizes.spaceBtwSections),
                _submitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextFormField(
      controller: context.read<ResetPasswordCubit>().emailController,
      validator: (value) => TValidator.validateEmail(value),
      decoration: const InputDecoration(
        labelText: AppStrings.email,
        prefixIcon: Icon(Iconsax.direct_right),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is CheckEmailSuccessState) {
          context.pushPage(
            const OtpScreen(reset: true),
            arguments: context
                .read<ResetPasswordCubit>()
                .emailController
                .text
                .trim(),
          );
          Loaders.successSnackBar(title: 'Success', message: state.message);
        } else if (state is CheckEmailFailureState) {
          Loaders.errorSnackBar(title: 'Error', message: state.message);
        }
      },
      builder: (context, state) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            await context.read<ResetPasswordCubit>().forgetPassword();
          },
          child: state is CheckEmailLoadingState
              ? const Center(
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: FittedBox(child: CircularProgressIndicator()),
                  ),
                )
              : const Text(AppStrings.submit),
        ),
      ),
    );
  }
}
