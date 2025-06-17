import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/personalization/presentation/widgets/intereste_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class InterestsSection extends StatelessWidget {
  const InterestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final activeColor = const Color(0xFF7165E3);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // -- Interests Title
        Row(
          children: [
            Text(
              'Interests',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontSize: 20),
            ),
            const Spacer(),

            // -- Edit Button
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.lg,
                  horizontal: 14.0,
                ),
                decoration: BoxDecoration(
                  color: activeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    // edit icon
                    const Icon(
                      Iconsax.edit_2,
                      size: 17,
                      color: AppColors.eventyPrimaryColor,
                    ),
                    const SizedBox(width: AppSizes.sm),

                    // edit text
                    Text(
                      'CHANGE',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontSize: 12,
                            color: AppColors.eventyPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSizes.spaceBtwItems - 4),

        // -- Interests Cards
        Wrap(
          spacing: 5,
          runSpacing: 10,
          children: List.generate(
            5,
            (index) => InteresteCard(interest: 'Interest $index'),
          ),
        ),
      ],
    );
  }
}
