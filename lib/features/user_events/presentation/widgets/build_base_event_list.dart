import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/user_events/presentation/cubits/base_events_state.dart';
import 'package:eventy/features/user_events/presentation/widgets/shimmer_event_list.dart';
import 'package:eventy/shared/widgets/event_widgets/horizontal_event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildBaseEventList<T extends Cubit<BaseEventsState>>
    extends StatelessWidget {
  const BuildBaseEventList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<T, BaseEventsState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is BaseEventLoading) {
            return ShimmerEventsList(key: ValueKey('events_shimmer'));
          }

          if (state is BaseEventError) {
            return Center(child: Text(state.message));
          }
          if (state is BaseEventLoaded) {
            if (state.events.isEmpty) {
              return Center(child: Text('No events found'));
            }
            return ListView.separated(
              padding: const EdgeInsets.only(
                bottom: AppSizes.spaceBtwSections,
                top: 6,
              ),
              itemCount: state.events.length,
              itemBuilder: (context, index) =>
                  HorizontalEventCard(event: state.events[index]),
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSizes.spaceBtwItems),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
