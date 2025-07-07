import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/widgets/shimmer/horizontal_event_card_shimmer.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/presentation/cubits/paginated_events_cubit.dart';
import 'package:eventy/features/user_events/presentation/cubits/paginated_events_state.dart';
import 'package:eventy/features/user_events/presentation/widgets/shimmer_event_list.dart';
import 'package:eventy/shared/widgets/animated_widget/custom_animation_list_view.dart';
import 'package:eventy/shared/widgets/empty_event_list.dart';
import 'package:eventy/shared/widgets/event_widgets/horizontal_event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildBaseEventList<T extends Cubit<PaginatedEventsState>>
    extends StatelessWidget {
  const BuildBaseEventList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<T, PaginatedEventsState>(
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
              return const EmptyEventList();
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 200) {
                  final cubit = context.read<T>() as PaginatedEventsCubit;
                  cubit.onLoadMore();
                }
                return true;
              },
              child: CustomAnimatedListView<EventEntity>(
                translateOffset: 100,
                padding: const EdgeInsets.only(
                  bottom: AppSizes.spaceBtwSections,
                  top: 6,
                ),
                items: state.events,
                animateOnlyOnFirstBuild: true,
                itemCount: state.events.length + (state.isLoadingMore ? 1 : 0),
                itemBuilder: (context, event, index) =>
                    state.isLoadingMore && index == state.events.length
                    ? HorizontalEventCardShimmer()
                    : HorizontalEventCard(event: event),
                separator: const SizedBox(height: AppSizes.spaceBtwItems),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
