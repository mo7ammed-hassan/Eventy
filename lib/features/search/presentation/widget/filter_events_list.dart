import 'package:eventy/shared/widgets/event_widgets/horizontal_event_card.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';

class FilterEventsList extends StatelessWidget {
  const FilterEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(
          bottom: AppSizes.spaceBtwSections,
          top: 6,
        ),
        itemCount: 6,
        itemBuilder: (context, index) => const HorizontalEventCard(),
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppSizes.spaceBtwItems),
      ),
    );
  }
}
