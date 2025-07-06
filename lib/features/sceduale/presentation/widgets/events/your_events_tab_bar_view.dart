import 'package:eventy/core/enums/enums.dart';
import 'package:eventy/features/sceduale/presentation/cubits/schedule_cubit.dart';
import 'package:eventy/features/sceduale/presentation/cubits/schedule_state.dart';
import 'package:eventy/features/sceduale/presentation/widgets/events/events_list_view.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YourEventsTabBarView extends StatefulWidget {
  const YourEventsTabBarView({super.key});

  @override
  State<YourEventsTabBarView> createState() => _YourEventsTabBarViewState();
}

class _YourEventsTabBarViewState extends State<YourEventsTabBarView> {
  bool hasLoaded = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!hasLoaded) {
      final cubit = context.read<ScheduleCubit>();
      cubit.getJoinedEvents(forceViewMode: ScheduleViewMode.full);
      hasLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSizes.slg,
        right: AppSizes.tabBarViewPadding,
        left: AppSizes.tabBarViewPadding,
        bottom: AppSizes.spaceBtwSections,
      ),
      child: CustomScrollView(
        clipBehavior: Clip.none,
        slivers: [
          BlocBuilder<ScheduleCubit, ScheduleState>(
            builder: (context, state) {
              return EventsListView(events: state.joinedEvents);
            },
          ),
        ],
      ),
    );
  }
}
