import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:eventy/core/cubits/password_and_selection/password_and_selection_cubit.dart';
import 'package:eventy/core/cubits/password_and_selection/password_and_selection_state.dart';
import 'package:eventy/core/utils/validators/validation.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    this.controller,
    this.labelText = 'Password',
    this.passwordField = true,
  });
  final TextEditingController? controller;
  final String? labelText;
  final bool passwordField;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordAndSelectionCubit, PasswordAndSelectionState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: passwordField
              ? state.isPasswordHidden
              : state.isConfirmPasswordHidden,
          controller: controller,
          validator: (value) => TValidator.validatePassword(value),
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.password],
          onEditingComplete: () => TextInput.finishAutofillContext(),
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: const Icon(Iconsax.password_check),
            errorMaxLines: 2,
            suffixIcon: IconButton(
              icon: Icon(
                passwordField
                    ? state.isPasswordHidden
                          ? Iconsax.eye_slash
                          : Iconsax.eye
                    : state.isConfirmPasswordHidden
                    ? Iconsax.eye_slash
                    : Iconsax.eye,
              ),
              onPressed: () {
                if (passwordField) {
                  context
                      .read<PasswordAndSelectionCubit>()
                      .togglePasswordVisibility();
                } else {
                  context
                      .read<PasswordAndSelectionCubit>()
                      .toggleConfirmPasswordVisibility();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
