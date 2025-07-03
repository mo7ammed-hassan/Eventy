import 'package:eventy/config/service_locator.dart';
import 'package:eventy/features/sceduale/presentation/cubits/schedule_cubit.dart';
import 'package:eventy/features/sceduale/presentation/widgets/events/events_list_view.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';

class YourEventsTabBarView extends StatefulWidget {
  const YourEventsTabBarView({super.key});

  @override
  State<YourEventsTabBarView> createState() => _YourEventsTabBarViewState();
}

class _YourEventsTabBarViewState extends State<YourEventsTabBarView> {
  late final ScheduleCubit scheduleCubit;
  @override
  void initState() {
    scheduleCubit = getIt<ScheduleCubit>();
    scheduleCubit.getJoinedEvents();
    super.initState();
  }

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
