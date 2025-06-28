import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/enums/enums.dart';
import 'package:eventy/core/widgets/progress_steps/flow_step_indicator.dart';
import 'package:eventy/core/widgets/progress_steps/flow_step_data.dart';

/// A custom stepper widget with visual indicators and step-by-step content.
/// Supports dynamic step navigation, animated transitions, and custom UI for each step.
/// Use it for onboarding flows, forms, or multi-step processes.
class CustomStepperFlow extends StatefulWidget {
  const CustomStepperFlow({
    super.key,
    required this.steps,
    this.padding,
    this.controller,
    this.contentTitlePadding,
    this.onSubmit,
    this.finishButtonText = 'Submit',
    this.nextButtonText = 'Next',
    this.previousButtonText = 'Previous',
    this.stepIndicatorBuilder,
  });

  /// List of steps to show in the stepper
  final List<FlowStepData> steps;

  /// Padding around the step content
  final EdgeInsetsGeometry? padding;

  /// Padding around the content title
  final EdgeInsetsGeometry? contentTitlePadding;

  /// Optional external controller to control step changes programmatically
  final StepperController? controller;

  /// Callback when the "Finish" button is tapped
  final VoidCallback? onSubmit;

  /// Text for the "Finish" button
  final String finishButtonText;

  /// Text for the "Next" button
  final String nextButtonText;

  /// Text for the "Previous" button
  final String previousButtonText;

  /// Custom builder for step indicators (optional)
  final Widget Function(BuildContext context, int index, StepStatus status)?
  stepIndicatorBuilder;

  @override
  State<CustomStepperFlow> createState() => _CustomStepperFlowState();
}

class _CustomStepperFlowState extends State<CustomStepperFlow> {
  late int _currentStep;
  late final List<Widget> stepIndicators;
  late final StepperController _internalController;

  @override
  void initState() {
    super.initState();
    _currentStep = 0;
    _internalController = StepperController(_handleStepChange);
    widget.controller?.attach(_internalController);
  }

  @override
  void dispose() {
    widget.controller?.detach();
    super.dispose();
  }

  void _handleStepChange(int newStep) {
    if (newStep >= 0 && newStep < widget.steps.length) {
      setState(() {
        _currentStep = newStep;
      });
    }
  }

  void _nextStepTap() => _handleStepChange(_currentStep + 1);
  void _previousStepTap() => _handleStepChange(_currentStep - 1);

  bool get _isLastStep => _currentStep == widget.steps.length - 1;
  //bool get _isFirstStep => _currentStep == 0;

  StepStatus _getStepStatus(int index) {
    if (index < _currentStep) return StepStatus.completed;
    if (index == _currentStep) return StepStatus.inProgress;
    return StepStatus.pending;
  }

  StepStatus _getPreviousStepStatus(int index) {
    if (index - 1 < _currentStep) {
      return StepStatus.completed;
    } else {
      return StepStatus.pending;
    }
  }

  Widget _buildStepIndicator(BuildContext context, int index) {
    final status = _getStepStatus(index);
    final previousStatus = _getPreviousStepStatus(index);

    if (widget.stepIndicatorBuilder != null) {
      return widget.stepIndicatorBuilder!(context, index, status);
    }

    return GestureDetector(
      onTap: () => _handleStepChange(index),
      child: FlowStepIndicator(
        isFirst: index == 0,
        isLast: index == widget.steps.length - 1,
        title: widget.steps[index].stepTitle ?? '',
        status: status,
        subTitle: '',
        index: index,
        stepStatus: previousStatus,
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _currentStep > 0 ? 1.0 : 0.0,
            child: IgnorePointer(
              /// -- To disable the button
              ignoring: _currentStep == 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _currentStep > 0 ? 46 : 0,
                child: _BuildNavigationButton(
                  key: const ValueKey('previous'),
                  title: 'Previous',
                  onTap: _previousStepTap,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: _BuildNavigationButton(
            key: const ValueKey('next'),
            title: _isLastStep
                ? widget.finishButtonText
                : widget.nextButtonText,
            onTap: _isLastStep ? widget.onSubmit : _nextStepTap,
            backgroundColor: _isLastStep ? AppColors.primaryColor : null,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentStepData = widget.steps[_currentStep];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),

        // Step Indicators
        Row(
          children: List.generate(
            widget.steps.length,
            (index) => Flexible(child: _buildStepIndicator(context, index)),
          ),
        ),
        const SizedBox(height: 28),

        // Content Title
        Padding(
          padding:
              widget.contentTitlePadding ??
              const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            currentStepData.contentTitle ?? '',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 16.0),

        // Step Content
        Expanded(
          child: Padding(
            padding: widget.padding ?? const EdgeInsets.all(16),
            child: Column(
              children: [
                // Step Content
                Expanded(
                  child: SingleChildScrollView(
                    child: IndexedStack(
                      index: _currentStep,
                      children: widget.steps
                          .map(
                            (step) => step.builder ?? const SizedBox.shrink(),
                          )
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Navigation Buttons
                _buildNavigationButtons(context),
              ],
            ),
          ),
        ),
        const SizedBox(height: kToolbarHeight / 2),
      ],
    );
  }
}

class _BuildNavigationButton extends StatelessWidget {
  const _BuildNavigationButton({
    super.key,
    required this.title,
    this.onTap,
    this.backgroundColor,
  });
  final String title;
  final Function()? onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
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
        child: FittedBox(key: ValueKey(title), child: Text(title)),
      ),
    );
  }
}

/// Controller to programmatically control [CustomStepperIndicatorWidget]
class StepperController {
  void Function(int)? _stepHandler;

  void attach(StepperController controller) {
    _stepHandler = controller._stepHandler;
  }

  void detach() {
    _stepHandler = null;
  }

  StepperController(this._stepHandler);

  /// Go to the next step
  void nextStep() => _stepHandler?.call(_currentStep + 1);

  /// Go to the previous step
  void previousStep() => _stepHandler?.call(_currentStep - 1);

  /// Go to a specific step index
  void goToStep(int index) => _stepHandler?.call(index);

  final int _currentStep = 0;
}
