import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/enums/enums.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class StepProgressWidget extends StatefulWidget {
  final List<StepData> steps;

  const StepProgressWidget({super.key, required this.steps});

  @override
  State<StepProgressWidget> createState() => _StepProgressWidgetState();
}

class _StepProgressWidgetState extends State<StepProgressWidget>
    with AutomaticKeepAliveClientMixin {
  int currentStepIndex = 0;
  bool isCurrentStepValid = false;

  void goToNextStep() {
    setState(() {
      widget.steps[currentStepIndex].status = StepStatus.completed;
      if (currentStepIndex < widget.steps.length - 1) {
        currentStepIndex++;
        widget.steps[currentStepIndex].status = StepStatus.inProgress;
        isCurrentStepValid = false;
      }
    });
  }

  void goToPreviousStep() {
    if (currentStepIndex == 0) return;
    setState(() {
      widget.steps[currentStepIndex].status = StepStatus.pending;
      currentStepIndex--;
      widget.steps[currentStepIndex].status = StepStatus.inProgress;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.steps[0].status = StepStatus.inProgress;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final steps = widget.steps;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(steps.length, (index) {
            return Expanded(
              child: StepIndicator(
                title: steps[index].title,
                status: steps[index].status,
                isLast: index == steps.length - 1,
              ),
            );
          }),
        ),
        const SizedBox(height: 32),

        steps[currentStepIndex].builder(),
        const SizedBox(height: 32),

        Spacer(),

        SizedBox(
          width: DeviceUtils.getScaledWidth(context, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: DeviceUtils.getScaledWidth(context, 0.42),
                child: ElevatedButton.icon(
                  icon: Icon(Iconsax.arrow_left, size: 24),
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: Colors.transparent,
                    padding: EdgeInsets.all(14),
                    shadowColor: Colors.transparent,
                  ),

                  onPressed: goToPreviousStep,
                  label: Text('Previous'),
                ),
              ),
              const SizedBox(width: AppSizes.spaceBtwTextField / 2),
              SizedBox(
                width: DeviceUtils.getScaledWidth(context, 0.42),
                child: ElevatedButton.icon(
                  icon: Icon(Iconsax.arrow_right_1, size: 24),
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: Colors.transparent,
                    iconAlignment: IconAlignment.end,
                    padding: EdgeInsets.all(14),
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: goToNextStep,
                  label: Text(
                    currentStepIndex == widget.steps.length - 1
                        ? 'Finish'
                        : 'Next',
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSizes.spaceBtwSections),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class StepIndicator extends StatelessWidget {
  final String title;
  final StepStatus status;
  final bool isLast;

  const StepIndicator({
    super.key,
    required this.title,
    required this.status,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final color = HelperFunctions.getColor(status, context);
    final icon = HelperFunctions.getIcon(status);
    final isDark = HelperFunctions.isDarkMode(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: status == StepStatus.completed
                      ? Color(0xFF26c37f)
                      : Color(0xFFbfbfc1),
                  width: 1.5,
                ),
              ),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: color,
                child: Icon(icon, size: 16, color: Colors.white),
              ),
            ),
            if (!isLast)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 2,
                        color: status == StepStatus.completed
                            ? Color(0xFF26c37f)
                            : status == StepStatus.inProgress
                            ? Color(0xFF3833f1)
                            : isDark
                            ? AppColors.darkerGrey
                            : Color(0xFFbfbfc1),
                      ),
                    ),
                    Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 2,
                        color: status == StepStatus.completed
                            ? Color(0xFF26c37f)
                            : isDark
                            ? AppColors.darkerGrey
                            : Color(0xFFbfbfc1),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontSize: 13),
        ),
        const SizedBox(height: 4),
        Text(
          status == StepStatus.completed
              ? "Completed"
              : status == StepStatus.inProgress
              ? "In Progress"
              : "Pending",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontSize: 10, color: color),
        ),
      ],
    );
  }
}

class StepData {
  final String title;
  final Widget Function() builder;
  StepStatus status;

  final GlobalKey<FormState>? formKey;

  StepData({
    required this.title,
    this.formKey,
    required this.builder,
    this.status = StepStatus.pending,
  });
}
