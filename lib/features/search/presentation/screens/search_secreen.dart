import 'package:eventy/shared/widgets/search/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/search/presentation/widget/filter_events_list.dart';

class SearchSecreen extends StatelessWidget {
  const SearchSecreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onChanged: (query) {},
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              const FilterEventsList(),
            ],
          ),
        ),
      ),
    );
  }
}
