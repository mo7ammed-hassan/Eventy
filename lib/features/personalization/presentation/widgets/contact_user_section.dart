import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ContactUserSection extends StatelessWidget {
  const ContactUserSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.eventyPrimaryColor),
          ),
          child: const Center(child: Icon(Iconsax.message)),
        ),
        SizedBox(
          width: DeviceUtils.getScaledWidth(context, 0.4),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () {},
            child: const Text('Follow'),
          ),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.eventyPrimaryColor),
          ),
          child: const Center(child: Icon(Iconsax.message)),
        ),
      ],
    );
  }
}
