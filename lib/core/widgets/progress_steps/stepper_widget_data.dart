import 'package:eventy/core/enums/enums.dart';
import 'package:flutter/material.dart';

/// Holds data for a single step in [CustomStepperIndicatorWidget].
class StepperWidgetData {
  final String? stepTitle;
  final String? contentTitle;
  final StepStatus? status;
  final Widget? builder;

  StepperWidgetData({
    this.builder,
    required this.stepTitle,
    required this.contentTitle,
    this.status = StepStatus.pending,
  });

  StepperWidgetData copyWith({
    String? stepTitle,
    String? contentTitle,
    StepStatus? status,
    Widget? builder,
  }) {
    return StepperWidgetData(
      stepTitle: stepTitle ?? this.stepTitle,
      contentTitle: contentTitle ?? this.contentTitle,
      status: status ?? this.status,
      builder: builder ?? this.builder,
    );
  }
}







// class StepperWidgetData {
//   final String? stepTitle;
//   final String? contentTitle;
//   final StepStatus? status;
//   final Widget? builder;

//   StepperWidgetData({
//     this.builder,
//     required this.stepTitle,
//     required this.contentTitle,
//     this.status = StepStatus.pending,
//   });

//   StepperWidgetData copyWith({
//     String? stepTitle,
//     StepStatus? status,
//     Widget? builder,
//     String? contentTitle,
//   }) {
//     return StepperWidgetData(
//       stepTitle: stepTitle ?? this.stepTitle,
//       contentTitle: contentTitle ?? this.contentTitle,
//       status: status ?? this.status,
//       builder: builder ?? this.builder,
//     );
//   }
// }
