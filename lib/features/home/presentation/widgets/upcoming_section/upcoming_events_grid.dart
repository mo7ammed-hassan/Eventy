import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/widgets/shimmer/upcoming_event_card_shimmer.dart';
import 'package:eventy/features/home/presentation/cubits/home_cubit.dart';
import 'package:eventy/features/home/presentation/cubits/home_state.dart';
import 'package:eventy/features/home/presentation/widgets/upcoming_section/upcoming_event_card.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingEventsGrid extends StatelessWidget {
  const UpcomingEventsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
      sliver: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return UpComingEventsGridShimmer(key: ValueKey('Upcoming Loading'));
          }
          if (state.upcomingEvents?.isEmpty ?? true) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }
          return SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18,
            ),
            itemBuilder: (context, index) => UpcomingEventCard(
              key: ValueKey(state.upcomingEvents?[index].id ?? ''),
              event: state.upcomingEvents?[index] ?? EventEntity.empty(),
            ),
            itemCount: state.upcomingEvents?.length ?? 0,
          );
        },
      ),
    );
  }
}

class UpComingEventsGridShimmer extends StatelessWidget {
  const UpComingEventsGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
      ),
      itemBuilder: (context, index) => const UpcomingEventCardShimmer(),
      itemCount: 4,
    );
  }
}
