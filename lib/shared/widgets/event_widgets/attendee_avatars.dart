import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/core/widgets/shimmer/shimmer_widget.dart';
import 'package:flutter/material.dart';

class AttendeeAvatars extends StatelessWidget {
  const AttendeeAvatars({
    super.key,
    required this.attendees,
    this.avatarSize = 12,
    this.height,
    this.width,
  });

  final List<String> attendees;
  final double avatarSize;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: SizedBox(
            width: width ?? 70,
            height: height ?? 30,
            child: Stack(
              children: List.generate(
                attendees.length > 3 ? 3 : attendees.length,
                (index) => Positioned(
                  left: index * 20,
                  child: CircleAvatar(
                    radius: avatarSize + 2,
                    backgroundColor: isDark ? AppColors.dark : Colors.white,
                    child: CachedNetworkImage(
                      imageUrl: attendees[index],
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: avatarSize,
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (_, __) => ShimmerWidget(
                        width: 65,
                        height: 25,
                        shapeBorder: const CircleBorder(),
                      ),
                      errorWidget: (_, __, ___) =>
                          const Icon(Icons.error, size: 12),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // -- User count
        Text(
          "+${attendees.length} Going",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class AttendeeAvatarsShimmer extends StatelessWidget {
  const AttendeeAvatarsShimmer({
    super.key,
    this.avatarSize = 12,
    this.height,
    this.width,
  });

  final double avatarSize;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: SizedBox(
            width: width ?? 70,
            height: height ?? 30,
            child: Stack(
              children: List.generate(
                3, // Always show 3 avatars in shimmer
                (index) => Positioned(
                  left: index * 20,
                  child: CircleAvatar(
                    radius: avatarSize + 2,
                    backgroundColor: isDark ? AppColors.dark : Colors.white,
                    child: ShimmerWidget(
                      width: avatarSize * 2,
                      height: avatarSize * 2,
                      shapeBorder: const CircleBorder(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        ShimmerWidget(
          width: 50,
          height: 14,
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
