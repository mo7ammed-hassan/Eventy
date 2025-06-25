import 'package:eventy/core/enums/enums.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final String? title;
  final String subTitle;
  final StepStatus status;
  final bool isFirst;
  final bool isLast;
  final int index;
  final StepStatus stepStatus;

  const StepIndicator({
    super.key,
    this.title,
    this.subTitle = '',
    required this.status,
    required this.stepStatus,
    required this.index,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = HelperFunctions.getColor(status, context);
    final icon = HelperFunctions.getIcon(status);
    final isDark = HelperFunctions.isDarkMode(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 3,
                color: isFirst
                    ? Colors.transparent
                    : HelperFunctions.getColor(stepStatus, context),
              ),
            ),
            // -- Step Icon
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              // padding: status != StepStatus.completed
              //     ? const EdgeInsets.all(1.5)
              //     : null,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
              ),
              child: AnimatedPadding(
                duration: const Duration(milliseconds: 300),
                padding: status != StepStatus.completed
                    ? const EdgeInsets.all(1.5 * 2)
                    : EdgeInsets.zero,
                child: AnimatedScale(
                  scale: status == StepStatus.inProgress ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: color,
                    child: Icon(icon, size: 16, color: Colors.white),
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Container(
                color: !isLast ? color : Colors.transparent,
                //margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Title
        Text(
          title ?? '',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),

        // Subtitle
        if (subTitle.isNotEmpty)
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),

        const SizedBox(height: 4),

        // Status Text
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: isDark ? 0.4 : 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            status.name,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: 10),
          ),
        ),
      ],
    );
  }
}
