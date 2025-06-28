import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
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
              height: DeviceUtils.getScaledHeight(context, 0.28),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      key: ValueKey('loading'),
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  return ListView.separated(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) => AspectRatio(
                      aspectRatio: 240 / 171,
                      child: const TrendingEventCard(key: ValueKey('')),
                    ),
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
