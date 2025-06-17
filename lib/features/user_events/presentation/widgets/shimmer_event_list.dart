import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/widgets/shimmer/horizontal_event_card_shimmer.dart';
import 'package:flutter/material.dart';

class ShimmerEventsList extends StatelessWidget {
  const ShimmerEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwSections, top: 6),
      itemCount: 6,
      itemBuilder: (context, index) => const HorizontalEventCardShimmer(),
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSizes.spaceBtwItems),
    );
  }
}
