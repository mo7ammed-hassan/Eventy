import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/features/personalization/presentation/widgets/edit_personal_info_card.dart';
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

              const UserInfoSection(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              EditPersonalInfoCard(
                title: 'Name',
                initialValue: 'Mohamed Hasan H.',
                onTap: () {},
              ),
              const SizedBox(height: AppSizes.spaceBtwItems + 2),

              EditPersonalInfoCard(
                title: 'Location',
                initialValue: 'Egypt ',
                onTap: () {},
              ),
              const SizedBox(height: AppSizes.spaceBtwItems + 2),

              EditPersonalInfoCard(
                title: 'Address',
                initialValue: 'Al Sharqiya, Zagazig',
                onTap: () {},
              ),
              const SizedBox(height: AppSizes.spaceBtwItems + 2),

              EditPersonalInfoCard(
                title: 'Phone Number',
                initialValue: '+201096493188',
                onTap: () {},
              ),
              SizedBox(height: AppSizes.spaceBtwSections * 1.5),

              // -- Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.eventyPrimaryColor,
                  ),
                  onPressed: () {},
                  child: const Text('Save Changes'),
                ),
              ),
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
