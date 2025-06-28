import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/home/presentation/cubits/home_cubit.dart';
import 'package:eventy/features/home/presentation/cubits/home_state.dart';
import 'package:eventy/features/home/presentation/widgets/upcoming_section/upcoming_event_card.dart';
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
            return const SliverToBoxAdapter(
              key: ValueKey('loading'),
              child: Center(child: CircularProgressIndicator.adaptive()),
            );
          }
          return SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18,
            ),
            itemBuilder: (context, index) =>
                const UpcomingEventCard(key: ValueKey('')),
            itemCount: 4,
          );
        },
      ),
    );
  }
}
