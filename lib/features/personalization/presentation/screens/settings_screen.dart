import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/features/personalization/presentation/widgets/interestes_section.dart';
import 'package:eventy/features/personalization/presentation/widgets/settings_options_section.dart';
import 'package:eventy/features/personalization/presentation/widgets/user_info_section.dart';
import 'package:eventy/shared/widgets/appBar/eventy_appbar.dart';
import 'package:eventy/shared/widgets/event_widgets/profile_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // -- App Bar
            _buildAppBar(context, isDark),

            // -- Profile Body
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.defaultPadding,
              ),
              child: Column(
                children: [
                  // -- Profile Avatar Widget
                  ProfileAvatar(
                    showBorder: true,
                    showEditButton: true,
                    radius: DeviceUtils.screenWidth(context) * 0.15,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  // -- User Info Section
                  const UserInfoSection(),
                  const SizedBox(height: AppSizes.spaceBtwSections),

                  // -- Settings Section
                  const SettingsOptionsSection(),

                  // -- Interests Section
                  const InterestsSection(),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  EventAppBar _buildAppBar(BuildContext context, bool isDark) {
    return EventAppBar(
      showTitle: false,
      leadingWidget: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back,
          size: 24,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        // notification icon
        IconButton(
          icon: const Icon(Iconsax.notification, size: 24),
          onPressed: () {},
        ),
      ],
    );
  }
}
