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
          if (state.filteredUpcomingEvents?.isEmpty ?? true) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }
          return SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18,
              childAspectRatio: 2 / 2.4,
            ),
            itemBuilder: (context, index) => TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: Duration(milliseconds: 500),
              builder: (context, value, child) => Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 50 * (1 - value)),
                  child: child,
                ),
              ),
              child: UpcomingEventCard(
                key: ValueKey(state.filteredUpcomingEvents?[index].id ?? ''),
                event:
                    state.filteredUpcomingEvents?[index] ?? EventEntity.empty(),
              ),
            ),
            itemCount: state.filteredUpcomingEvents?.length ?? 0,
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
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
        childAspectRatio: 2 / 2.4,
      ),
      itemBuilder: (context, index) => const UpcomingEventCardShimmer(),
      itemCount: 4,
    );
  }
}
