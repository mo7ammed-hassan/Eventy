import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventy/config/routing/routes.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/constants/app_styles.dart';
import 'package:eventy/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/core/widgets/shimmer/shimmer_widget.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/shared/widgets/event_widgets/attendee_avatars.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';

class HorizontalEventCard extends StatelessWidget {
  const HorizontalEventCard({super.key, this.event});
  final EventEntity? event;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () =>
          context.pushNamedPage(Routes.eventDetailsScreen, arguments: event),
      child: AspectRatio(
        aspectRatio: 2 / 0.82,
        child: Container(
          padding: const EdgeInsets.only(
            right: AppSizes.spaceBtwItems,
            left: AppSizes.spaceBtwItems,
            top: AppSizes.defaultPadding / 2,
            bottom: AppSizes.defaultPadding / 2,
            //vertical: AppSizes.defaultPadding,
          ),
          decoration: _buildCardDecoration(isDark),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // User Info
                    Flexible(child: _UserInfoSection(event)),
                    const SizedBox(height: AppSizes.lg),

                    // -- Event Title & Location
                    _EventDetailsSection(event),
                    const SizedBox(height: AppSizes.lg),

                    // -- Attendees Avatars
                    Flexible(
                      fit: FlexFit.loose,
                      child: AttendeeAvatars(
                        avatarSize: 10,
                        width: 60,
                        fntSize: 12,
                        attendees: [
                          'https://images.unsplash.com/photo-1633332755192-727a05c4013d?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5j8nUEqIX1fJuWCjZxWDh1rL-QL_cq2A-85035phw9d-hiWbpU7r6H2WKRJ2spHwcJGE&usqp=CAU',
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmx-wxle_unpBUp-PdatrfcHp3ljhBkIHdLeEmYmn6CYmJrpMAzOVfUxCu9CKX19zxsqA&usqp=CAU',
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.lg),

              // -- Event Image
              Flexible(flex: 2, child: _EventImageSection(event?.image ?? '')),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildCardDecoration(bool isDark) {
    return BoxDecoration(
      color: isDark ? const Color.fromARGB(255, 26, 25, 25) : Colors.white,
      borderRadius: BorderRadius.circular(AppSizes.eventCardRadius),
      boxShadow: AppStyles.eventCardShadow(isDark),
    );
  }
}

class _UserInfoSection extends StatelessWidget {
  const _UserInfoSection(this.event);
  final EventEntity? event;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // -- User Avatar
          CachedNetworkImage(
            imageUrl: event?.user.imageUrl ?? AppImages.defaultUserImageUrl,
            imageBuilder: (_, imageProvider) =>
                CircleAvatar(radius: 16, backgroundImage: imageProvider),
            placeholder: (_, __) => const ShimmerWidget(
              width: 18,
              height: 18,
              shapeBorder: CircleBorder(),
            ),
            errorWidget: (_, __, ___) => const CircleAvatar(
              radius: 16,
              child: Icon(Icons.error, size: 16),
            ),
          ),
          const SizedBox(width: AppSizes.md),

          // -- User email & name
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      event?.user.name ?? 'Unknown',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      event?.user.email ?? 'Unknown',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventDetailsSection extends StatelessWidget {
  const _EventDetailsSection(this.event);
  final EventEntity? event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            event?.name ?? 'Unknown',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 12,
                color: Colors.grey,
              ),
              Expanded(
                child: Text(
                  event?.location.address ?? '45, Street, Cairo, Egypt',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EventImageSection extends StatelessWidget {
  const _EventImageSection(this.image);
  final String image;

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
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              width: imageWidth,
              height: imageHight,
              placeholder: (context, url) => const ShimmerWidget(),
              errorWidget: (context, url, error) => ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.eventCardRadius),
                child: Image.network(
                  AppImages.defaultEventImageUrl,
                  fit: BoxFit.cover,
                  width: imageWidth,
                  height: imageHight,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
