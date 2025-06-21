import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/user_events/presentation/widgets/build_base_event_list.dart';
import 'package:eventy/features/user_events/presentation/cubits/pending_events_cubit.dart';
import 'package:eventy/shared/widgets/appBar/custom_event_appbar.dart';
import 'package:eventy/shared/widgets/search/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingEventsScreen extends StatefulWidget {
  const PendingEventsScreen({super.key});
  static final ValueNotifier<bool> _showSearchBar = ValueNotifier<bool>(false);

  @override
  State<PendingEventsScreen> createState() => _PendingEventsScreenState();
}

class _PendingEventsScreenState extends State<PendingEventsScreen> {
  late final PendingEventsCubit _pendingEventsCubit;

  @override
  void initState() {
    super.initState();
    _pendingEventsCubit = getIt<PendingEventsCubit>();
    _pendingEventsCubit.getEventsList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _pendingEventsCubit,
      child: Scaffold(
        appBar: CustomEventAppBar(
          title: 'Pending Events',
          showSearchBar: PendingEventsScreen._showSearchBar,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.defaultPadding,
            ),
            child: Column(
              children: [
                SearchBarWidget(
                  showSearchBar: PendingEventsScreen._showSearchBar,
                  onChanged: (query) {},
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                const BuildBaseEventList<PendingEventsCubit>(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
