import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class DateField extends StatelessWidget {
  const DateField({super.key, required this.date, this.onTap});
  final String date;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.dateFieldPadding,
          horizontal: AppSizes.dateFieldPadding + 4,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColors.dark : AppColors.dateFieldColor,
          borderRadius: BorderRadius.circular(AppSizes.dateFieldRadius),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(date, style: Theme.of(context).textTheme.bodyMedium),
            ),
            const SizedBox(width: 4),

            Icon(Iconsax.calendar, color: AppColors.primaryColor, size: 26),
          ],
        ),
      ),
    );
  }
}
