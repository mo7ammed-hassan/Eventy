import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_styles.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/core/widgets/shimmer/shimmer_widget.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/presentation/cubits/favorite_events_cubit.dart';
import 'package:eventy/features/user_events/presentation/cubits/paginated_events_state.dart';
import 'package:eventy/shared/widgets/event_widgets/attendee_avatars.dart';
import 'package:eventy/shared/widgets/event_widgets/profile_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class HorizontalEventCard extends StatelessWidget {
  const HorizontalEventCard({super.key, this.event});
  final EventEntity? event;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: DeviceUtils.screenWidth(context),
            height: DeviceUtils.getScaledHeight(context, 0.17),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spaceBtwItems,
              vertical: AppSizes.defaultPadding,
            ),
            decoration: _buildCardDecoration(isDark),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // User Info
                      _UserInfoSection(event),
                      const SizedBox(height: AppSizes.lg),

                      // -- Event Title & Location
                      _EventDetailsSection(event),
                      const SizedBox(height: AppSizes.lg),

                      // -- Attendees Avatars
                      Flexible(
                        flex: 3,
                        fit: FlexFit.loose,
                        child: FittedBox(
                          child: AttendeeAvatars(
                            attendees: [
                              'https://images.unsplash.com/photo-1633332755192-727a05c4013d?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5j8nUEqIX1fJuWCjZxWDh1rL-QL_cq2A-85035phw9d-hiWbpU7r6H2WKRJ2spHwcJGE&usqp=CAU',
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmx-wxle_unpBUp-PdatrfcHp3ljhBkIHdLeEmYmn6CYmJrpMAzOVfUxCu9CKX19zxsqA&usqp=CAU',
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.lg),

                // -- Event Image
                Flexible(
                  flex: 2,
                  child: _EventImageSection(event?.image ?? ''),
                ),
              ],
            ),
          ),

          // -- Robot icon
          Positioned(
            top: -12,
            right: -10,
            child: BlocBuilder<FavoriteEventsCubit, PaginatedEventsState>(
              bloc: getIt.get<FavoriteEventsCubit>(),
              builder: (context, state) {
                bool isAlreadyFavorite = false;
                if (state is BaseEventLoaded) {
                  isAlreadyFavorite = state.events.any(
                    (e) => e.id == event?.id,
                  );
                }
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: IconButton(
                    key: ValueKey<bool>(isAlreadyFavorite),
                    onPressed: () => getIt
                        .get<FavoriteEventsCubit>()
                        .toggleFavorite(event: event ?? EventEntity.empty()),
                    icon: Icon(
                      isAlreadyFavorite ? Iconsax.star5 : Iconsax.star,
                    ),
                    color: isAlreadyFavorite
                        ? AppColors.secondaryColor
                        : Colors.grey,
                  ),
                );
              },
            ),
          ),
        ],
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
      flex: 4,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // -- User Avatar
          ProfileAvatar(radius: 16),
          const SizedBox(width: AppSizes.md),

          // -- User email & name
          Flexible(
            child: FittedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: DeviceUtils.screenWidth(context) * 0.5,
                    child: Text(
                      event?.hostCompany ?? 'Unknown',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: DeviceUtils.screenWidth(context) * 0.5,
                    child: Text(
                      '@username',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
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
    return Flexible(
      flex: 4,
      fit: FlexFit.loose,
      child: Padding(
        padding: const EdgeInsets.only(left: 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                event?.name ?? 'Unknown',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: AppSizes.sm),

            Flexible(
              flex: 2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: FittedBox(
                      child: const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      event?.location.address ?? '45, Street, Cairo, Egypt',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                  'https://media.istockphoto.com/id/499517325/photo/a-man-speaking-at-a-business-conference.jpg?s=612x612&w=0&k=20&c=gWTTDs_Hl6AEGOunoQ2LsjrcTJkknf9G8BGqsywyEtE=',
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
