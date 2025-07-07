import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomPaymentAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomPaymentAppBar({
    super.key,
    required this.title,
    this.backgroundColor,
    this.textColor,
  });
  final String title;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Iconsax.arrow_left,
          size: 24,
          color: textColor ?? (isDark ? Colors.white : Colors.black),
        ),
        onPressed: () => Navigator.pop(context),
      ),

      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(fontSize: 18, color: textColor),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
