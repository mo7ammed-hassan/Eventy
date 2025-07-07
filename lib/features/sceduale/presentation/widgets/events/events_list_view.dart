import 'package:eventy/core/widgets/shimmer/shimmer_list_view.dart';
import 'package:eventy/features/sceduale/presentation/cubits/schedule_cubit.dart';
import 'package:eventy/features/sceduale/presentation/widgets/build_event_list_view.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({super.key, required this.events});

  final List<EventEntity> events;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ScheduleCubit>();
    final state = context.watch<ScheduleCubit>().state;

    if (state.isLoading) return const EventsListViewShimmer();

    if (state.errorMessage != null && !state.isLoading) {
      return SliverToBoxAdapter(
        child: Center(child: Text(state.errorMessage ?? 'There was an error')),
      );
    }

    return BuildEventList(cubit: cubit, events: events, state: state);
  }
}
