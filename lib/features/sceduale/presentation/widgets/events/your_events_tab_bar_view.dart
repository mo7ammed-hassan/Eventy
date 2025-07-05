import 'package:eventy/features/sceduale/presentation/cubits/schedule_cubit.dart';
import 'package:eventy/features/sceduale/presentation/widgets/events/events_list_view.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YourEventsTabBarView extends StatelessWidget {
  const YourEventsTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ScheduleCubit>().getJoinedEvents();
    return const Padding(
      padding: EdgeInsets.only(
        top: AppSizes.slg,
        right: AppSizes.tabBarViewPadding,
        left: AppSizes.tabBarViewPadding,
        bottom: AppSizes.spaceBtwSections,
      ),
      child: CustomScrollView(
        clipBehavior: Clip.none,
        slivers: [EventsListView()],
      ),
    );
  }
}
