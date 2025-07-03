import 'package:eventy/config/service_locator.dart';
import 'package:eventy/features/search/presentation/cubits/search_cubit.dart';
import 'package:eventy/shared/widgets/search/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/search/presentation/widget/filter_events_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchSecreen extends StatefulWidget {
  const SearchSecreen({super.key});

  @override
  State<SearchSecreen> createState() => _SearchSecreenState();
}

class _SearchSecreenState extends State<SearchSecreen> {
  late final SearchCubit _searchCubit;

  @override
  void initState() {
    super.initState();
    _searchCubit = getIt<SearchCubit>();
    _searchCubit.getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _searchCubit,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.defaultScreenPadding,
            ),
            child: Column(
              children: [
                const SizedBox(height: AppSizes.lg),
                SearchBarWidget(
                  showSearchBar: ValueNotifier<bool>(true),
                  onChanged: (query) => _searchCubit.searchEvents(query),
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),

                const FilterEventsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
