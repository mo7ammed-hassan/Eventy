import 'package:eventy/core/constants/app_colors.dart';
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
    this.contentpadding,
    this.onSubmit,
    this.finishButtonText = 'Submit',
  });

  /// List of steps to show in the stepper.
  final List<StepperWidgetData> steps;

  /// Padding around the step content.
  final EdgeInsetsGeometry? padding;

  /// Padding around the step content.
  final EdgeInsetsGeometry? contentpadding;

  /// Optional external controller to control step changes programmatically.
  final StepperController? controller;

  /// Function to be called when the "Finish" button is tapped.
  final Function()? onSubmit;

  /// Text for the "Finish" button.
  final String finishButtonText;

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
        const SizedBox(height: 28),

        /// --- Content Title
        Padding(
          padding:
              widget.contentpadding ??
              const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            stepData.contentTitle ?? '',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),

        /// --- Title
        Expanded(
          child: Padding(
            padding: widget.padding ?? const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  children: [
                    Expanded(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: currentStep > 0 ? 1.0 : 0.0,
                        child: IgnorePointer(
                          /// -- To disable the button
                          ignoring: currentStep <= 0,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: currentStep > 0 ? 48 : 0,
                            child: _buildButton(
                              title: 'Previous',
                              onTap: _previousStep,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12.0),

                    Expanded(
                      child: _buildButton(
                        key: const ValueKey('next'),
                        backgroundColor: _isLastStep
                            ? AppColors.primaryColor
                            : null,
                        onTap: _isLastStep ? widget.onSubmit : _nextStep,
                        title: _isLastStep ? widget.finishButtonText : 'Next',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: kToolbarHeight / 2),
      ],
    );
  }

  Widget _buildButton({
    required String title,
    required VoidCallback? onTap,
    Color? backgroundColor,
    Key? key,
  }) {
    return ElevatedButton(
      key: key,
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        backgroundColor: backgroundColor ?? AppColors.secondaryColor,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              axis: Axis.horizontal,
              child: child,
            ),
          );
        },
        child: Text(title, key: ValueKey(title)),
      ),
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
