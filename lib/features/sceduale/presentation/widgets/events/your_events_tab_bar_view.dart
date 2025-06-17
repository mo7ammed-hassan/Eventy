import 'package:eventy/features/sceduale/presentation/widgets/events/events_list_view.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';

class YourEventsTabBarView extends StatelessWidget {
  const YourEventsTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        top: AppSizes.slg,
        right: AppSizes.tabBarViewPadding,
        left: AppSizes.tabBarViewPadding,
        bottom: AppSizes.spaceBtwSections,
      ),
      child: CustomScrollView(
        clipBehavior: Clip.none,
        slivers: [EventsListView()],
      ),
    );
  }
}
