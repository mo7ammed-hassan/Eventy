import 'package:eventy/shared/widgets/search/search_bar_widget.dart';
import 'package:flutter/material.dart';

class SearchScreenHeader extends StatelessWidget {
  const SearchScreenHeader({super.key, required this.onFilterButtonPressed});
  final VoidCallback onFilterButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SearchBarWidget(
              showSearchBar: ValueNotifier<bool>(true),
              onChanged: (query) {},
            ),
          ),
        ],
      ),
    );
  }
}
