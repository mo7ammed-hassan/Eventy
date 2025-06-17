import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/cubits/password_and_selection/password_and_selection_cubit.dart';
import 'package:eventy/core/cubits/password_and_selection/password_and_selection_state.dart';
import 'package:eventy/core/widgets/checkbox/custom_checkbox.dart';

class TTermAndCondationCheckbox extends StatelessWidget {
  const TTermAndCondationCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        BlocBuilder<PasswordAndSelectionCubit, PasswordAndSelectionState>(
          builder: (context, state) {
            return CustomCheckbox(
              value: state.isPrivacyAccepted,
              onChanged: (value) {
                context
                    .read<PasswordAndSelectionCubit>()
                    .togglePrivacyAcceptance();
              },
            );
          },
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'I agree to ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: isDark ? AppColors.white : AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: isDark
                        ? AppColors.white
                        : AppColors.primaryColor,
                  ),
                ),
                TextSpan(
                  text: 'and ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: 'Terms of use',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: isDark
                        ? AppColors.white
                        : AppColors.primaryTextColor,
                    decoration: TextDecoration.underline,
                    decorationColor: isDark
                        ? AppColors.white
                        : AppColors.primaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
