import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/home/presentation/widgets/categories_section/event_category_tabs.dart';
import 'package:eventy/features/home/presentation/widgets/header_section/event_home_search_bar.dart';
import 'package:eventy/features/home/presentation/widgets/header_section/location_selector_header.dart';
import 'package:eventy/features/home/presentation/widgets/trending_section/trending_events_list.dart';
import 'package:eventy/features/home/presentation/widgets/upcoming_section/upcoming_events_grid.dart';
import 'package:eventy/shared/widgets/event_widgets/section_header.dart';
import 'package:eventy/shared/widgets/event_widgets/sliver_sized_box.dart';
import 'package:flutter/material.dart';

class EventHomeScreenBody extends StatelessWidget {
  const EventHomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// -- Home Header
            /// -- LocationSelectorHeader
            const LocationSelectorHeader(),
            const SliverSizedBox(height: AppSizes.spaceBtwSections),

            /// -- Search Bar
            const EventHomeSearchBar(),
            const SliverSizedBox(height: AppSizes.spaceBtwItems),

            /// -- Home Body
            // -- EventCategoryTabs
            const EventCategoryTabs(),
            SliverToBoxAdapter(
              child: const SizedBox(height: AppSizes.spaceBtwSections),
            ),

            // -- TrendingEventsList
            const TrendingEventsList(),
            SliverSizedBox(height: AppSizes.spaceBtwSections),

            // -- UpcomingEventsGrid
            // -- Upcoming Events Header
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.defaultPadding,
              ),
              sliver: SliverToBoxAdapter(
                child: TSectionHeader(
                  title: 'Upcoming Events',
                  bottomTitle: 'View All',
                ),
              ),
            ),
            const SliverSizedBox(height: AppSizes.spaceBtwItems),

            // -- UpcomingEventsGrid
            const UpcomingEventsGrid(),
            const SliverSizedBox(height: AppSizes.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}
