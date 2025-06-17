import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/shared/widgets/event_widgets/general_rounded_container.dart';
import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, this.title, required this.children});
  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GeneralRoundedContainer(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.lg,
        horizontal: AppSizes.sm,
      ),
      radius: 10.0,
      child: Column(children: children),
    );
  }
}
