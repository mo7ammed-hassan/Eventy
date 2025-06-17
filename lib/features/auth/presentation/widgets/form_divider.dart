import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_colors.dart';

class TFormDivider extends StatelessWidget {
  final String dividerText;
  const TFormDivider({super.key, required this.dividerText});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: isDark ? AppColors.dividerColor : AppColors.grayColor,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(dividerText, style: Theme.of(context).textTheme.labelMedium),
        Flexible(
          child: Divider(
            color: isDark ? AppColors.dividerColor : AppColors.grayColor,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
