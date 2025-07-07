import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventy/config/routing/routes.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/app_styles.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/core/widgets/shimmer/shimmer_widget.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/shared/widgets/event_widgets/archive_icon_widget.dart';
import 'package:eventy/shared/widgets/event_widgets/attendee_avatars.dart';
import 'package:flutter/material.dart';

class TrendingEventCard extends StatelessWidget {
  const TrendingEventCard({super.key, this.event});
  final EventEntity? event;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () =>
          context.pushNamedPage(Routes.eventDetailsScreen, arguments: event),
      child: Container(
        width: DeviceUtils.getScaledWidth(context, 0.8),
        decoration: _buildCardDecoration(isDark),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final imageHight = constraints.maxHeight * 0.67;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // -- TrendingEventCard Header
                // -- Image
                SizedBox(
                  height: imageHight,
                  // -- Top widgets
                  child: Stack(
                    children: [
                      // -- Event Image
                      _EventImageSection(event?.image),
                      // -- Top ribbon
                      Positioned.fill(
                        child: _TopRibbon(event ?? EventEntity.empty()),
                      ),
                    ],
                  ),
                ),

                // -- TrendingEventCard Body
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // -- Event title
                      Text(
                        '${event?.name} / ${event?.formattedDate}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),

                      // -- Event Price
                      Align(
                        alignment: Alignment.centerRight,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            event?.paid == true
                                ? 'Rs {${event?.price}}'
                                : 'Free',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                          ),
                        ),
                      ),

                      // -- User whos join
                      AttendeeAvatars(
                        avatarSize: 10,
                        width: 60,
                        fntSize: 12,
                        attendees: [
                          'https://images.unsplash.com/photo-1633332755192-727a05c4013d?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5j8nUEqIX1fJuWCjZxWDh1rL-QL_cq2A-85035phw9d-hiWbpU7r6H2WKRJ2spHwcJGE&usqp=CAU',
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmx-wxle_unpBUp-PdatrfcHp3ljhBkIHdLeEmYmn6CYmJrpMAzOVfUxCu9CKX19zxsqA&usqp=CAU',
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  BoxDecoration _buildCardDecoration(bool isDark) {
    return BoxDecoration(
      color: isDark ? AppColors.dark : Colors.white,
      borderRadius: BorderRadius.circular(AppSizes.eventCardRadius),
      boxShadow: AppStyles.eventCardShadow(isDark),
    );
  }
}

class _EventImageSection extends StatelessWidget {
  const _EventImageSection(this.imageUrl);
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: AppStyles.eventCardRadius,
        child: CachedNetworkImage(
          imageUrl: imageUrl ?? AppImages.defaultEventImage,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          placeholder: (context, url) => const ShimmerWidget(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

class _TopRibbon extends StatelessWidget {
  const _TopRibbon(this.event);
  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -- Top widget
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSizes.eventCardRadius),
              bottomRight: Radius.circular(AppSizes.eventCardRadius),
            ),
          ),
          child: const Text(
            "Top",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // -- archive icon
        ArchiveIconWidget(event: event),
      ],
    );
  }
}


