import 'package:eventy/core/widgets/shimmer/custom_animated_sliver_list.dart';
import 'package:eventy/core/widgets/shimmer/horizontal_event_card_shimmer.dart';
import 'package:eventy/features/sceduale/presentation/cubits/schedule_cubit.dart';
import 'package:eventy/features/sceduale/presentation/cubits/schedule_state.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/shared/widgets/event_widgets/horizontal_event_card.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';

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
      child: CustomAnimatedSliverListView<EventEntity>(
        items: events,
        itemCount: events.length + (state.isLoadMore ? 1 : 0),
        padding: const EdgeInsets.only(
          right: 8.0,
          left: 8.0,
          bottom: 16.0,
          top: 8.0,
        ),
        stopAnimationNearEnd: 3,
        itemBuilder: (context, event, index) =>
            state.isLoadMore && index == events.length
            ? const HorizontalEventCardShimmer()
            : HorizontalEventCard(event: event!),
        separator: const SizedBox(height: AppSizes.spaceBtwItems),
      ),
    );
  }
}
