import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/user_events/presentation/widgets/build_base_event_list.dart';
import 'package:eventy/features/user_events/presentation/cubits/favorite_events_cubit.dart';
import 'package:eventy/shared/widgets/appBar/custom_event_appbar.dart';
import 'package:eventy/shared/widgets/search/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteEventsScreen extends StatelessWidget {
  const FavoriteEventsScreen({super.key});
  static final ValueNotifier<bool> _showSearchBar = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final cubit = getIt.get<FavoriteEventsCubit>();
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: CustomEventAppBar(
          title: 'Favorite',
          showSearchBar: _showSearchBar,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.defaultPadding,
            ),
            child: Column(
              children: [
                SearchBarWidget(
                  showSearchBar: _showSearchBar,
                  onChanged: (query) => cubit.searchEventsByTitle(query: query),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                // Favourite  Events List
                const BuildBaseEventList<FavoriteEventsCubit>(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
