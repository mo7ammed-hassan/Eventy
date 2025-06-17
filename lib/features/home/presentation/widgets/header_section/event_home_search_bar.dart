import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EventHomeSearchBar extends StatelessWidget {
  const EventHomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.grayColor : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Enter city or region',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintStyle: TextStyle(color: isDark ? Colors.white : Colors.grey),
              contentPadding: EdgeInsets.all(16),
              prefixIcon: Icon(
                Iconsax.search_normal,
                color: isDark ? Colors.white : Colors.black,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.tune,
                  size: 26,
                  color: isDark ? Colors.white : AppColors.filtterIconColor,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
