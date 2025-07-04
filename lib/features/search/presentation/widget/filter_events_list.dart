import 'package:eventy/features/search/presentation/cubits/search_cubit.dart';
import 'package:eventy/features/search/presentation/cubits/search_state.dart';
import 'package:eventy/features/user_events/presentation/widgets/shimmer_event_list.dart';
import 'package:eventy/shared/widgets/animated_widget/animated_list_layout.dart';
import 'package:eventy/shared/widgets/empty_event_list.dart';
import 'package:eventy/shared/widgets/event_widgets/horizontal_event_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterEventsList extends StatelessWidget {
  const FilterEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Expanded(child: const ShimmerEventsList());
        }

        if (state.events.isEmpty || state.filterList.isEmpty) {
          return const EmptyEventList(title: 'Type to search');
        }

        return Expanded(
          child: AnimatedListLayout(
            itemCount: state.filterList.length,
            itemBuilder: (context, index) =>
                HorizontalEventCard(event: state.filterList[index]),
          ),
        );
      },
    );
  }
}
