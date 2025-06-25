import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/enums/enums.dart';
import 'package:eventy/core/widgets/progress_steps/step_indicator.dart';
import 'package:eventy/core/widgets/progress_steps/stepper_widget_data.dart';
import 'package:flutter/material.dart';

/// A custom stepper widget with visual indicators and step-by-step content.
///
/// Supports dynamic step navigation, animated transitions, and custom UI for each step.
/// Use it for onboarding flows, forms, or multi-step processes.
class CustomStepperIndicatorWidget extends StatefulWidget {
  const CustomStepperIndicatorWidget({
    super.key,
    required this.steps,
    this.padding,
    this.controller,
  });

  /// List of steps to show in the stepper.
  final List<StepperWidgetData> steps;

  /// Padding around the step content.
  final EdgeInsetsGeometry? padding;

  /// Optional external controller to control step changes programmatically.
  final StepperController? controller;

  @override
  State<CustomStepperIndicatorWidget> createState() =>
      _CustomStepperIndicatorWidgetState();
}

class _CustomStepperIndicatorWidgetState
    extends State<CustomStepperIndicatorWidget> {
  late int currentStep;
  late int previousStep;

  @override
  void initState() {
    super.initState();
    currentStep = 0;
    previousStep = 0;

    widget.controller?._attach(this);
  }

  void _goToStep(int index) {
    if (index >= 0 && index < widget.steps.length) {
      setState(() {
        previousStep = currentStep;
        currentStep = index;
      });
    }
  }

  void _nextStep() => _goToStep(currentStep + 1);

  void _previousStep() => _goToStep(currentStep - 1);

  bool get _isLastStep => currentStep == widget.steps.length - 1;

  @override
  Widget build(BuildContext context) {
    final stepData = widget.steps[currentStep];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),

        /// --- Step Indicators Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.steps.length, (index) {
            return Flexible(
              fit: FlexFit.tight,
              child: GestureDetector(
                onTap: () => _goToStep(index),
                child: StepIndicator(
                  isFirst: index == 0,
                  isLast: index == widget.steps.length - 1,
                  title: widget.steps[index].stepTitle ?? '',
                  status: index < currentStep
                      ? StepStatus.completed
                      : index == currentStep
                      ? StepStatus.inProgress
                      : StepStatus.pending,
                  stepStatus: index - 1 < currentStep
                      ? StepStatus.completed
                      : StepStatus.pending,
                  subTitle: '',
                  index: index,
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 26),

        /// --- Title + Content
        Expanded(
          child: Padding(
            padding: widget.padding ?? const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stepData.contentTitle ?? '',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontSize: 18),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                /// Step Content
                Expanded(
                  child: IndexedStack(
                    index: currentStep,
                    children: widget.steps
                        .map((step) => step.builder ?? const SizedBox.shrink())
                        .toList(),
                  ),
                ),

                const SizedBox(height: AppSizes.spaceBtwItems),

                /// --- Bottom Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentStep > 0)
                      ElevatedButton(
                        onPressed: _previousStep,
                        child: const Text('Previous'),
                      ),
                    ElevatedButton(
                      onPressed: _isLastStep ? () {} : _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3833f1),
                      ),
                      child: Text(_isLastStep ? 'Submit' : 'Next Step'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Controller to programmatically control [CustomStepperIndicatorWidget].
class StepperController {
  _CustomStepperIndicatorWidgetState? _state;

  void _attach(_CustomStepperIndicatorWidgetState state) {
    _state = state;
  }

  /// Go to the next step
  void nextStep() => _state?._nextStep();

  /// Go to the previous step
  void previousStep() => _state?._previousStep();

  /// Go to a specific step index
  void goToStep(int index) => _state?._goToStep(index);
}

// class CustomStepperIndicatorWidget extends StatefulWidget {
//   const CustomStepperIndicatorWidget({
//     super.key,
//     required this.steps,
//     this.padding,
//   });
//   final List<StepperWidgetData> steps;
//   final EdgeInsetsGeometry? padding;

//   @override
//   State<CustomStepperIndicatorWidget> createState() =>
//       _CustomStepperIndicatorWidgetState();
// }

// class _CustomStepperIndicatorWidgetState
//     extends State<CustomStepperIndicatorWidget> {
//   int currentStep = 0;
//   int previousStep = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // -- Steper Indicators
//         const SizedBox(height: 14),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: List.generate(
//             widget.steps.length,
//             (index) => Flexible(
//               fit: FlexFit.tight,
//               child: GestureDetector(
//                 onTap: () => setState(() => currentStep = index),
//                 child: StepIndicator(
//                   isFirst: index == 0,
//                   title: widget.steps[index].stepTitle ?? '',
//                   status: index < currentStep
//                       ? StepStatus.completed
//                       : index == currentStep
//                       ? StepStatus.inProgress
//                       : StepStatus.pending,
//                   isLast: index == widget.steps.length - 1,
//                   subTitle: '',
//                   stepStatus: index - 1 < currentStep
//                       ? StepStatus.completed
//                       : StepStatus.pending,
//                   index: index,
//                 ),
//               ),
//             ),
//           ),
//         ),

//         const SizedBox(height: 26),

//         /// --- Content Title
//         Expanded(
//           child: Padding(
//             padding: widget.padding ?? const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.steps[currentStep].contentTitle ?? '',
//                   style: Theme.of(
//                     context,
//                   ).textTheme.titleMedium?.copyWith(fontSize: 18),
//                 ),
//                 const SizedBox(height: AppSizes.spaceBtwItems),

//                 /// Step content
//                 // SingleChildScrollView(
//                 //   child: AnimatedSwitcher(
//                 //     duration: Duration(milliseconds: 600),
//                 //     child: widget.steps[currentStep].builder ?? Container(),
//                 //   ),
//                 // ),
//                 SingleChildScrollView(
//                   child: AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 300),
//                     transitionBuilder: (child, animation) {
//                       final isForward = currentStep > previousStep;

//                       final offsetAnimation = Tween<Offset>(
//                         begin: isForward
//                             ? const Offset(1.0, 0.0)
//                             : const Offset(-1.0, 0.0),
//                         end: Offset.zero,
//                       ).animate(animation);

//                       return SlideTransition(
//                         position: offsetAnimation,
//                         child: child,
//                       );
//                     },
//                     child: KeyedSubtree(
//                       key: ValueKey(currentStep),
//                       child:
//                           widget.steps[currentStep].builder ??
//                           const SizedBox.shrink(),
//                     ),
//                   ),
//                 ),

//                 Spacer(),

//                 // Bottom Button
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: SizedBox(
//                     width: DeviceUtils.getScaledWidth(context, 0.3),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFF3833f1),
//                       ),
//                       onPressed: () {
//                         if (currentStep < 3) {
//                           setState(() => currentStep++);
//                         } else {
//                           // Submit
//                         }
//                       },
//                       child: Text(
//                         currentStep == widget.steps.length - 1
//                             ? 'Submit'
//                             : 'Next Step',
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //   children: [
//                 //     if (currentStep > 0)
//                 //       SizedBox(
//                 //         width: DeviceUtils.getScaledWidth(context, 0.3),
//                 //         child: ElevatedButton(
//                 //           onPressed: () => setState(() => currentStep--),
//                 //           child: const Text('Previous'),
//                 //         ),
//                 //       ),
//                 //     SizedBox(
//                 //       width: DeviceUtils.getScaledWidth(context, 0.3),
//                 //       child: ElevatedButton(
//                 //         onPressed: () {
//                 //           if (currentStep < widget.steps.length - 1) {
//                 //             setState(() => currentStep++);
//                 //           } else {
//                 //             // Submit logic
//                 //           }
//                 //         },
//                 //         child: Text(
//                 //           currentStep == widget.steps.length - 1
//                 //               ? 'Submit'
//                 //               : 'Next Step',
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//               ],
//             ),
//           ),
//         ),

//         const SizedBox(height: AppSizes.spaceBtwSections * 2),
//       ],
//     );
//   }
// }
