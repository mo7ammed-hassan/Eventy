import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EventAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EventAppBar({
    super.key,
    this.title = 'Eventy',
    this.leadingWidget,
    this.actions,
    this.showTitle = true, this.backgroundColor, this.titleColor,
  });
  final String title;
  final Widget? leadingWidget;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: leadingWidget,
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor,
      title: showTitle
          ? Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                
                color: titleColor ?? (isDark ? Colors.white : AppColors.filtterIconColor),
              ),
            )
          : null,
      actions:
          actions ??
          [
            // Search Icon
            IconButton(
              icon: Icon(
                Iconsax.search_normal,
                size: 24,
                color: isDark ? Colors.white : AppColors.filtterIconColor,
              ),
              onPressed: () {},
            ),

            // Notification Icon
            IconButton(
              icon: Icon(
                Iconsax.direct_notification,
                size: 24,
                color: isDark ? Colors.white : AppColors.filtterIconColor,
              ),
              onPressed: () {},
            ),
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
