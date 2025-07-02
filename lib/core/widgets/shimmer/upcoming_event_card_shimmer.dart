import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/app_styles.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/core/widgets/shimmer/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UpcomingEventCardShimmer extends StatelessWidget {
  const UpcomingEventCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight = constraints.maxHeight * 0.66;
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.dark : Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.eventCardRadius),
            boxShadow: AppStyles.eventCardShadow(isDark),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Image + Icon
              Flexible(
                flex: 2,
                child: Stack(
                  children: [
                    // Image shimmer
                    ClipRRect(
                      borderRadius: AppStyles.eventCardRadius,
                      child: ShimmerWidget(
                        width: double.infinity,
                        height: imageHeight,
                      ),
                    ),
                    // Archive icon
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Icon(Iconsax.archive_1, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // --- Title & Address
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerWidget(
                        width: constraints.maxWidth * 0.7,
                        height: 16,
                      ),
                      const SizedBox(height: 8),
                      ShimmerWidget(
                        width: constraints.maxWidth * 0.45,
                        height: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
