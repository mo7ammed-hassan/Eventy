import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/user_events/presentation/widgets/build_base_event_list.dart';
import 'package:eventy/features/user_events/presentation/cubits/created_events_cubit.dart';
import 'package:eventy/shared/widgets/appBar/custom_event_appbar.dart';
import 'package:eventy/shared/widgets/search/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatedEventsScreen extends StatefulWidget {
  const CreatedEventsScreen({super.key});
  static final ValueNotifier<bool> _showSearchBar = ValueNotifier<bool>(false);

  @override
  State<CreatedEventsScreen> createState() => _CreatedEventsScreenState();
}

class _CreatedEventsScreenState extends State<CreatedEventsScreen> {
  late final CreatedEventsCubit _createdEventsCubit;

  @override
  void initState() {
    super.initState();
    _createdEventsCubit = getIt<CreatedEventsCubit>();
    _createdEventsCubit.getEventsList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _createdEventsCubit,
      child: Scaffold(
        appBar: CustomEventAppBar(
          title: 'Created Events',
          showSearchBar: CreatedEventsScreen._showSearchBar,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.defaultPadding,
            ),
            child: Column(
              children: [
                SearchBarWidget(
                  showSearchBar: CreatedEventsScreen._showSearchBar,
                  onChanged: (query) =>
                      _createdEventsCubit.searchEventsByTitle(query: query),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                // Favourite  Events List
                const BuildBaseEventList<CreatedEventsCubit>(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
