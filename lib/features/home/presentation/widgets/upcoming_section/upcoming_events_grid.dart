import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/home/presentation/widgets/upcoming_section/upcoming_event_card.dart';
import 'package:flutter/material.dart';

class UpcomingEventsGrid extends StatelessWidget {
  const UpcomingEventsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 18,
          crossAxisSpacing: 18,
        ),
        itemBuilder: (context, index) =>
            const UpcomingEventCard(key: ValueKey('')),
        itemCount: 4,
      ),
    );
  }
}
