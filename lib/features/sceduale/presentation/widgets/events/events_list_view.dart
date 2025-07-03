import 'package:eventy/core/widgets/shimmer/horizontal_event_card_shimmer.dart';
import 'package:eventy/features/sceduale/presentation/cubits/schedule_cubit.dart';
import 'package:eventy/features/sceduale/presentation/cubits/schedule_state.dart';
import 'package:eventy/shared/widgets/empty_event_list.dart';
import 'package:eventy/shared/widgets/event_widgets/horizontal_event_card.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/user_events/data/models/event_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({super.key, this.events, this.isCalender = false});
  final List<EventModel>? events;
  final bool isCalender;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ScheduleCubit>();
    return BlocBuilder<ScheduleCubit, ScheduleState>(
      builder: (context, state) {
        if (state.isLoading) return EventsListViewShimmer();

        if (state.errorMessage != null && state.isLoading == false) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(state.errorMessage ?? 'There was an error'),
            ),
          );
        }

        if (state.currentEvents.isEmpty && state.isLoading == false) {
          return SliverToBoxAdapter(
            child: EmptyEventList(
              height: isCalender
                  ? MediaQuery.of(context).size.height * 0.2
                  : null,
            ),
          );
        }

        if (state.currentEvents.isNotEmpty && state.isLoading == false) {
          final events = state.currentEvents;
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                cubit.getJoinedEvents(isLoadMore: true);
              }
              return true;
            },
            child: SliverList.separated(
              itemCount: state.joinedEvents.length + (state.isLoadMore ? 1 : 0),
              itemBuilder: (context, index) =>
                  state.isLoadMore && index == state.joinedEvents.length
                  ? HorizontalEventCardShimmer()
                  : HorizontalEventCard(event: events[index]),
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSizes.spaceBtwItems),
            ),
          );
        }

        return const SliverToBoxAdapter();
      },
    );
  }
}

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
