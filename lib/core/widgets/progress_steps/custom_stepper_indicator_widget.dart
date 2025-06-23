import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/enums/enums.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/widgets/progress_steps/step_indicator.dart';
import 'package:eventy/core/widgets/progress_steps/stepper_widget_data.dart';
import 'package:flutter/material.dart';

class CustomStepperIndicatorWidget extends StatefulWidget {
  const CustomStepperIndicatorWidget({
    super.key,
    required this.steps,
    this.padding,
  });
  final List<StepperWidgetData> steps;
  final EdgeInsetsGeometry? padding;

  @override
  State<CustomStepperIndicatorWidget> createState() =>
      _CustomStepperIndicatorWidgetState();
}

class _CustomStepperIndicatorWidgetState
    extends State<CustomStepperIndicatorWidget> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -- Steper Indicators
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            widget.steps.length,
            (index) => Flexible(
              fit: FlexFit.tight,
              child: GestureDetector(
                onTap: () => setState(() => currentStep = index),
                child: StepIndicator(
                  isFirst: index == 0,
                  title: widget.steps[index].stepTitle ?? '',
                  status: index < currentStep
                      ? StepStatus.completed
                      : index == currentStep
                      ? StepStatus.inProgress
                      : StepStatus.pending,
                  isLast: index == widget.steps.length - 1,
                  subTitle: '',
                  stepStatus: index - 1 < currentStep
                      ? StepStatus.completed
                      : StepStatus.pending,
                  index: index,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 26),

        /// --- Content Title
        Expanded(
          child: Padding(
            padding: widget.padding ?? const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.steps[currentStep].contentTitle ?? '',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontSize: 18),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                /// Step content
                SingleChildScrollView(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: widget.steps[currentStep].builder ?? Container(),
                  ),
                ),

                Spacer(),

                // Bottom Button
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: DeviceUtils.getScaledWidth(context, 0.3),
                    child: ElevatedButton(
                      onPressed: () {
                        if (currentStep < 3) {
                          setState(() => currentStep++);
                        } else {
                          // Submit
                        }
                      },
                      child: Text(
                        currentStep == widget.steps.length - 1
                            ? 'Submit'
                            : 'Next Step',
                      ),
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     if (currentStep > 0)
                //       SizedBox(
                //         width: DeviceUtils.getScaledWidth(context, 0.3),
                //         child: ElevatedButton(
                //           onPressed: () => setState(() => currentStep--),
                //           child: const Text('Previous'),
                //         ),
                //       ),
                //     SizedBox(
                //       width: DeviceUtils.getScaledWidth(context, 0.3),
                //       child: ElevatedButton(
                //         onPressed: () {
                //           if (currentStep < widget.steps.length - 1) {
                //             setState(() => currentStep++);
                //           } else {
                //             // Submit logic
                //           }
                //         },
                //         child: Text(
                //           currentStep == widget.steps.length - 1
                //               ? 'Submit'
                //               : 'Next Step',
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),

        const SizedBox(height: AppSizes.spaceBtwSections),
      ],
    );
  }
}
