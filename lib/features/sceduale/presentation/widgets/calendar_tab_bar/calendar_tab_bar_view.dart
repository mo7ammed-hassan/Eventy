import 'package:eventy/features/sceduale/presentation/widgets/events/events_list_view.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/sceduale/presentation/widgets/calendar_tab_bar/calender_section.dart';

class CalendarTabBarView extends StatelessWidget {
  const CalendarTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: AppSizes.defaultScreenPadding,
        left: AppSizes.defaultScreenPadding,
      ),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: AppSizes.sm)),
          SliverToBoxAdapter(child: CalenderSection()),
          const SliverToBoxAdapter(
            child: Divider(
              thickness: 1,
              color: Colors.grey,
              height: AppSizes.dividerHeight,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSizes.defaultPadding),
          ),

          const EventsListView(isCalender: true),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSizes.spaceBtwSections),
          ),
        ],
      ),
    );
  }
}
