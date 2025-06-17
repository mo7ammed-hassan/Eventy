import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class ProfileSettingTile extends StatelessWidget {
  const ProfileSettingTile({
    super.key,
    this.onTap,
    this.leadingIcon,
    required this.title,
    this.trailingOnTap,
    this.showTrailing = false,
    this.trailingText,
    this.minTileHeight = 28.0,
    this.leadingIconColor,
    this.titleColor,
  });
  final Function()? onTap, trailingOnTap;
  final IconData? leadingIcon;
  final bool showTrailing;
  final String title;
  final String? trailingText;
  final double? minTileHeight;
  final Color? leadingIconColor;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveColor = isDark ? AppColors.white : AppColors.darkerGrey;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      minVerticalPadding: 0,
      minTileHeight: minTileHeight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
      leading: Icon(leadingIcon, color: leadingIconColor ?? effectiveColor),
      title: Text(
        title,
        style: AppTextStyle.textStyle16Bold(
          context,
        ).copyWith(color: titleColor ?? effectiveColor),
      ),
      trailing: showTrailing
          ? Text(
              trailingText!,
              style: AppTextStyle.textStyle16Bold(context).copyWith(
                color: AppColors.eventyPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            )
          : null,
    );
  }
}
