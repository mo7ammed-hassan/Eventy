import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/features/personalization/presentation/widgets/user_info_form_section.dart';
import 'package:eventy/features/personalization/presentation/widgets/user_info_section.dart';
import 'package:eventy/shared/widgets/event_widgets/profile_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EditPersonalInfoScreen extends StatelessWidget {
  const EditPersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.defaultPadding,
          ),
          child: ListView(
            children: [
              // -- AppBar
              _buildAppBar(context),

              // -- Profile Avatar Widget
              ProfileAvatar(
                showBorder: true,
                showEditButton: true,
                radius: DeviceUtils.screenWidth(context) * 0.15,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),

              const UserInfoSection(key: ValueKey('edit_info_section')),
              const SizedBox(height: AppSizes.spaceBtwSections),

              const UserInfoFormSection(),
              const SizedBox(height: AppSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  // -- AppBar
  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Iconsax.arrow_left, size: 24),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.notification, size: 24),
        ),
      ],
    );
  }
}
