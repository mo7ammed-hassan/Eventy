import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class InteresteCard extends StatelessWidget {
  const InteresteCard({super.key, required this.interest});
  final String interest;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.lg,
        horizontal: AppSizes.slg,
      ),
      decoration: BoxDecoration(
        color: HelperFunctions.randomColorGenerator().withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        interest,
        style: Theme.of(
          context,
        ).textTheme.headlineSmall?.copyWith(fontSize: 15, color: Colors.white),
      ),
    );
  }
}
