import 'package:eventy/core/constants/app_sizes.dart' show AppSizes;
import 'package:eventy/features/search/presentation/cubits/search_cubit.dart';
import 'package:eventy/features/search/presentation/cubits/search_state.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/presentation/widgets/shimmer_event_list.dart';
import 'package:eventy/shared/widgets/animated_widget/custom_animation_list_view.dart';
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
          child: CustomAnimatedListView<EventEntity>(
            padding: const EdgeInsets.only(
              bottom: AppSizes.spaceBtwSections + 6,
              top: 6,
            ),
            items: state.filterList,
            itemCount: state.filterList.length,
            scrollDirection: Axis.vertical,
            separator: const SizedBox(height: AppSizes.spaceBtwEventCards),
            itemBuilder: (context, event, index) =>
                HorizontalEventCard(event: event),
          ),
        );
      },
    );
  }
}
