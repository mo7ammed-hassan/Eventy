import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TSectionHeader extends StatelessWidget {
  const TSectionHeader({
    super.key,
    required this.title,
    this.bottomTitle,
    this.onTap,
    this.showTrailing = true,
  });

  final String title;
  final String? bottomTitle;
  final Function()? onTap;
  final bool showTrailing;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // -- Title
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(width: 4),

        // -- View All btn
        if (showTrailing)
          GestureDetector(
            onTap: onTap,
            child: Text(
              bottomTitle ?? 'View All',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: isDark ? AppColors.textBtnColor : AppColors.primaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
      ],
    );
  }
}
