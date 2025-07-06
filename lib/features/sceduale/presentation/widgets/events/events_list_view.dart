import 'package:eventy/core/widgets/shimmer/horizontal_event_card_shimmer.dart';
import 'package:eventy/features/sceduale/presentation/cubits/schedule_cubit.dart';
import 'package:eventy/features/sceduale/presentation/cubits/schedule_state.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/shared/widgets/event_widgets/horizontal_event_card.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({super.key, required this.events});

  final List<EventEntity> events;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ScheduleCubit>();
    final state = context.watch<ScheduleCubit>().state;

    if (state.isLoading) return const EventsListViewShimmer();

    if (state.errorMessage != null && !state.isLoading) {
      return SliverToBoxAdapter(
        child: Center(child: Text(state.errorMessage ?? 'There was an error')),
      );
    }

    return BuildEventList(cubit: cubit, events: events, state: state);
  }
}


class BuildEventList extends StatelessWidget {
  const BuildEventList({
    super.key,
    required this.cubit,
    required this.events,
    required this.state,
  });

  final ScheduleCubit cubit;
  final List<EventEntity> events;
  final ScheduleState state;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          cubit.getJoinedEvents(isLoadMore: true);
        }
        return true;
      },
      child: SliverList.separated(
        itemCount: events.length + (state.isLoadMore ? 1 : 0),
        itemBuilder: (context, index) =>
            state.isLoadMore && index == events.length
            ? HorizontalEventCardShimmer()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: HorizontalEventCard(event: events[index]),
              ),
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppSizes.spaceBtwItems),
      ),
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
