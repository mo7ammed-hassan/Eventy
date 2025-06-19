import 'package:eventy/config/routing/routes.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:eventy/features/personalization/presentation/widgets/profile_setting_tile.dart';
import 'package:eventy/features/personalization/presentation/widgets/settings_group.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SettingsOptionsSection extends StatelessWidget {
  const SettingsOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        // -- Account Settings Group
        SettingsGroup(
          title: 'Account Settings',
          children: [
            ProfileSettingTile(
              leadingIcon: Iconsax.edit,
              title: 'Edit profile information',
              onTap: () => context.pushNamedPage(Routes.editPersonalInfoScreen),
            ),
            ProfileSettingTile(
              leadingIcon: Iconsax.notification,
              title: 'Notifications',
              showTrailing: true,
              trailingText: 'ON',
              onTap: () {},
            ),
            ProfileSettingTile(
              leadingIcon: Iconsax.language_circle,
              title: 'Language',
              showTrailing: true,
              trailingText: 'English',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        // -- General Settings Group
        SettingsGroup(
          title: 'General Settings',
          children: [
            ProfileSettingTile(
              title: 'Security',
              leadingIcon: Iconsax.security_safe,
              onTap: () {},
            ),
            ProfileSettingTile(
              title: 'Theme',
              leadingIcon: Iconsax.moon,
              showTrailing: true,
              trailingText: isDarkMode ? 'Dark mode' : 'Light mode',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        // -- Support Settings Group
        SettingsGroup(
          title: 'Support',
          children: [
            ProfileSettingTile(
              title: 'Help & Support',
              leadingIcon: Iconsax.message_question,
              onTap: () {},
            ),
            ProfileSettingTile(
              title: 'Contact Us',
              leadingIcon: Iconsax.message,
              onTap: () {},
            ),
            ProfileSettingTile(
              title: 'Privacy Policy',
              leadingIcon: Iconsax.lock_1,
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),
      ],
    );
  }
}
