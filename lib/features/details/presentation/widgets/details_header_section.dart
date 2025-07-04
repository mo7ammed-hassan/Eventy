import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class DetailsHeaderSection extends StatelessWidget {
  const DetailsHeaderSection({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.blueGrey : AppColors.primaryColor,
      ),
    );
  }
}
