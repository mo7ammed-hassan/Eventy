import 'package:eventy/core/enums/enums.dart';
import 'package:flutter/material.dart';

/// Holds data for a single step in [CustomStepperFlow].
class FlowStepData {
  final String? stepTitle;
  final String? contentTitle;
  final StepStatus? status;
  final Widget? builder;

  const FlowStepData({
    required this.builder,
    required this.stepTitle,
    required this.contentTitle,
    this.status = StepStatus.pending,
  });

  FlowStepData copyWith({
    String? stepTitle,
    String? contentTitle,
    StepStatus? status,
    Widget? builder,
  }) {
    return FlowStepData(
      stepTitle: stepTitle ?? this.stepTitle,
      contentTitle: contentTitle ?? this.contentTitle,
      status: status ?? this.status,
      builder: builder ?? this.builder,
    );
  }
}
