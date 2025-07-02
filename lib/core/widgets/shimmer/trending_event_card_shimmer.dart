import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/app_styles.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/core/widgets/shimmer/shimmer_widget.dart';
import 'package:eventy/shared/widgets/event_widgets/attendee_avatars.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TrendingEventCardShimmer extends StatelessWidget {
  const TrendingEventCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Container(
      width: DeviceUtils.getScaledWidth(context, 0.8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.dark : Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.eventCardRadius),
        boxShadow: AppStyles.eventCardShadow(isDark),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final imageHeight = constraints.maxHeight * 0.65;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Image with Top Ribbon Shimmer
              SizedBox(
                height: imageHeight,
                child: Stack(
                  children: [
                    // Image Shimmer
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppSizes.eventCardRadius),
                          topRight: Radius.circular(AppSizes.eventCardRadius),
                        ),
                        child: ShimmerWidget(
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    // Top Ribbon
                    Positioned(
                      top: 0,
                      left: 0,
                      child: ShimmerWidget(
                        width: 60,
                        height: 30,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22.0,
                          vertical: 8.0,
                        ),
                        shapeBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppSizes.eventCardRadius),
                            bottomRight: Radius.circular(
                              AppSizes.eventCardRadius,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Archive Icon Shimmer
                    Positioned(
                      top: 10,
                      right: 10,
                      child: const Icon(Iconsax.archive_1, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // --- Body Content
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event title
                      ShimmerWidget(
                        width: constraints.maxWidth * 0.7,
                        height: 16,
                      ),
                      const SizedBox(height: 8),

                      // Price
                      Align(
                        alignment: Alignment.centerRight,
                        child: ShimmerWidget(
                          width: constraints.maxWidth * 0.25,
                          height: 14,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Avatars
                      Flexible(
                        flex: 4,
                        child: FittedBox(child: AttendeeAvatarsShimmer()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
