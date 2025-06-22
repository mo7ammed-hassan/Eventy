import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/user_events/presentation/widgets/build_base_event_list.dart';
import 'package:eventy/features/user_events/presentation/cubits/favorite_events_cubit.dart';
import 'package:eventy/shared/widgets/appBar/custom_event_appbar.dart';
import 'package:eventy/shared/widgets/search/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteEventsScreen extends StatefulWidget {
  const FavoriteEventsScreen({super.key});
  static final ValueNotifier<bool> _showSearchBar = ValueNotifier<bool>(false);

  @override
  State<FavoriteEventsScreen> createState() => _FavoriteEventsScreenState();
}

class _FavoriteEventsScreenState extends State<FavoriteEventsScreen> {
  late final FavoriteEventsCubit _favoriteEventsCubit;

  @override
  void initState() {
    _favoriteEventsCubit = getIt<FavoriteEventsCubit>();
    _favoriteEventsCubit.getEventsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _favoriteEventsCubit,
      child: Scaffold(
        appBar: CustomEventAppBar(
          title: 'Favorite',
          showSearchBar: FavoriteEventsScreen._showSearchBar,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.defaultPadding,
            ),
            child: Column(
              children: [
                SearchBarWidget(
                  showSearchBar: FavoriteEventsScreen._showSearchBar,
                  onChanged: (query) =>
                      _favoriteEventsCubit.searchEventsByTitle(query: query),
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
