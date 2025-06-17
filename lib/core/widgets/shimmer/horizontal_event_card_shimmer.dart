import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/widgets/shimmer/shimmer_widget.dart';
import 'package:eventy/shared/widgets/event_widgets/attendee_avatars.dart';
import 'package:flutter/material.dart';

class HorizontalEventCardShimmer extends StatelessWidget {
  const HorizontalEventCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceUtils.getScaledHeight(context, 0.17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.eventCardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spaceBtwItems,
          vertical: AppSizes.defaultPadding,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side content
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // User info shimmer
                  const Row(
                    children: [
                      CircleShimmer(diameter: 32),
                      SizedBox(width: AppSizes.md),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerWidget(width: 100, height: 16),
                          SizedBox(height: 4),
                          ShimmerWidget(width: 80, height: 12),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.lg),

                  // Event details shimmer
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerWidget(width: 150, height: 18),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          ShimmerWidget(width: 14, height: 14),
                          SizedBox(width: 4),
                          ShimmerWidget(width: 80, height: 12),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.lg),

                  // Attendees avatars shimmer
                  Flexible(
                    flex: 3,
                    fit: FlexFit.loose,
                    child: FittedBox(child: AttendeeAvatarsShimmer()),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSizes.sm),

            // Right side image shimmer
            const Flexible(flex: 2, child: EventCardImageShimmer()),
          ],
        ),
      ),
    );
  }
}

class CircleShimmer extends StatelessWidget {
  final double diameter;

  const CircleShimmer({super.key, required this.diameter});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      width: diameter,
      height: diameter,
      shapeBorder: const CircleBorder(),
    );
  }
}

class EventCardImageShimmer extends StatelessWidget {
  const EventCardImageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 5, bottom: 5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final imageHight = constraints.maxHeight;
          final imageWidth = constraints.maxWidth;
          return ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.eventCardRadius),
            child: ShimmerWidget(width: imageWidth, height: imageHight),
          );
        },
      ),
    );
  }
}
