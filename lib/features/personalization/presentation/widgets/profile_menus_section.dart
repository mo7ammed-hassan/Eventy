import 'package:eventy/config/routing/routes.dart';
import 'package:eventy/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:eventy/features/personalization/presentation/widgets/profile_menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileMenusSection extends StatelessWidget {
  const ProfileMenusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileMenuTile(
          icon: Iconsax.user,
          title: 'Personal Information',
          subtitle: 'Manage your personal information',
          onTap: () => context.pushNamedPage(Routes.editPersonalInfoScreen),
        ),
        ProfileMenuTile(
          icon: Iconsax.safe_home,
          title: 'My Address',
          subtitle: 'Set your default address',
          onTap: () {},
        ),
        ProfileMenuTile(
          icon: Iconsax.heart,
          title: 'Favorites',
          subtitle: 'Your favorite events',
          onTap: () => context.pushNamedPage(Routes.favoriteScreen),
        ),
        ProfileMenuTile(
          icon: Iconsax.calendar,
          title: 'Your Created Events',
          subtitle: 'Manage your created events',
          onTap: () => context.pushNamedPage(Routes.createdEventScreen),
        ),
        ProfileMenuTile(
          icon: Iconsax.ticket,
          title: 'Pending Events',
          subtitle: 'Events you are going to attend',
          onTap: () => context.pushNamedPage(Routes.pendingEvenstScreen),
        ),
    
        ProfileMenuTile(
          icon: Iconsax.setting,
          title: 'Account Settings',
          subtitle: 'Manage your account settings',
          onTap: () => context.pushNamedPage(Routes.settingsScreen),
        ),
      ],
    );
  }
}
