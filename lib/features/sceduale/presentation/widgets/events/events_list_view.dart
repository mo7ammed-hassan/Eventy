import 'package:eventy/shared/widgets/event_widgets/horizontal_event_card.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/user_events/data/models/event_model.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({super.key, this.events});
  final List<EventModel>? events;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: events?.length ?? 6,
      itemBuilder: (context, index) => HorizontalEventCard(),
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSizes.spaceBtwItems),
    );
  }
}
