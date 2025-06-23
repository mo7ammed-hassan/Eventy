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
            Container(
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: status != StepStatus.completed
                    ? const EdgeInsets.all(1.5)
                    : null,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: color,
                  child: Icon(icon, size: 16, color: Colors.white),
                ),
              ),
            ),

            // Line
            (!isLast)
                ? Expanded(
                    flex: 1,
                    child: Container(
                      color: color,
                      //margin: const EdgeInsets.symmetric(horizontal: 1),
                      height: 3,
                    ),
                  )
                : Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.transparent,
                      //margin: const EdgeInsets.symmetric(horizontal: 1),
                      height: 3,
                    ),
                  ),
          ],
        ),
        const SizedBox(height: 8),

        // Title
        Text(
          title ?? '',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),

        // Subtitle
        if (subTitle.isNotEmpty)
          Text(
            subTitle,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),

        const SizedBox(height: 4),

        // Status Text
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
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


/*
 (!isFirst)
                ? Expanded(
                    flex: 1,
                    child: Container(
                      //margin: const EdgeInsets.symmetric(horizontal: 1),
                      height: 3,
                      color: HelperFunctions.getColor(
                        stepStatus,
                        context,
                      ), // last index
                    ),
                  )
                : Expanded(
                    flex: 1,
                    child: Container(
                      //margin: const EdgeInsets.symmetric(horizontal: 1),
                      height: 3,
                      color: Colors.transparent,
                    ),
                  ),

 */