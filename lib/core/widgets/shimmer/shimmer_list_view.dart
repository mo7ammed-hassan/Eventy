import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/widgets/shimmer/horizontal_event_card_shimmer.dart';
import 'package:flutter/material.dart';

class EventsListViewShimmer extends StatelessWidget {
  const EventsListViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: 6,
      itemBuilder: (context, index) => const HorizontalEventCardShimmer(),
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSizes.spaceBtwItems),
    );
  }
}
