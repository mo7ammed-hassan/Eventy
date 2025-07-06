import 'package:eventy/features/sceduale/presentation/cubits/schedule_cubit.dart';
import 'package:eventy/features/sceduale/presentation/cubits/schedule_state.dart';
import 'package:eventy/features/sceduale/presentation/widgets/events/events_list_view.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/sceduale/presentation/widgets/calendar_tab_bar/calender_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarTabBarView extends StatefulWidget {
  const CalendarTabBarView({super.key});

  @override
  State<CalendarTabBarView> createState() => _CalendarTabBarViewState();
}

class _CalendarTabBarViewState extends State<CalendarTabBarView>
    with AutomaticKeepAliveClientMixin {
  bool hasLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cubit = context.read<ScheduleCubit>();
    cubit.getEventsPerDay(selectedDate: cubit.state.selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.defaultScreenPadding,
      ),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: AppSizes.sm)),
          const SliverToBoxAdapter(child: CalenderSection()),
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
        BlocBuilder<ScheduleCubit, ScheduleState>(
            builder: (context, state) {
              return EventsListView(events: state.eventsPerDay);
            },
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppSizes.spaceBtwSections),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
