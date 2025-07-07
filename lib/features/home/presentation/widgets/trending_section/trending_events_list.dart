import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/widgets/shimmer/trending_event_card_shimmer.dart';
import 'package:eventy/features/home/presentation/cubits/home_cubit.dart';
import 'package:eventy/features/home/presentation/cubits/home_state.dart';
import 'package:eventy/features/home/presentation/widgets/trending_section/trending_event_card.dart';
import 'package:eventy/shared/widgets/event_widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingEventsList extends StatelessWidget {
  const TrendingEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsetsGeometry.symmetric(
        horizontal: AppSizes.defaultPadding,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            // -- Trending Events Header
            const TSectionHeader(
              title: 'Trending Events near you',
              bottomTitle: 'View All',
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),

            // -- Trending Events List
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, 0.31),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return TrendingEventListShimmer(
                      key: ValueKey('Trending Loading'),
                    );
                  }
                  return ListView.separated(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.filterdTrendingEvents?.length ?? 0,
                    itemBuilder: (context, index) {
                      final event = state.trendingEvents?[index];
                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: Duration(
                          milliseconds: 500 + index * 100,
                        ), // Staggered effect
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(50 * (1 - value), 0),
                              child: AspectRatio(
                                aspectRatio: 215 / 161,
                                child: TrendingEventCard(
                                  key: ValueKey(event?.id ?? index),
                                  event: event,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: AppSizes.spaceBtwEventCards),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrendingEventListShimmer extends StatelessWidget {
  const TrendingEventListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) => AspectRatio(
        aspectRatio: 240 / 171,
        child: const TrendingEventCardShimmer(),
      ),
      separatorBuilder: (context, index) =>
          const SizedBox(width: AppSizes.spaceBtwEventCards),
    );
  }
}
