import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomEventAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomEventAppBar({super.key, required this.showSearchBar, this.title});

  final ValueNotifier<bool> showSearchBar;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.defaultPadding),
      child: AppBar(
        title: Text(
          title ?? '',
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontSize: 18),
        ),
        titleSpacing: 0,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.pop(context),
          child: Center(
            child: Icon(
              Iconsax.arrow_left,
              size: 24,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),

        actions: [
          IconButton(
            icon: Icon(Iconsax.search_normal, size: 24),
            onPressed: () => showSearchBar.value = !showSearchBar.value,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
