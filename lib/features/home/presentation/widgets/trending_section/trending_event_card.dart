import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/app_styles.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/core/widgets/shimmer/shimmer_widget.dart';
import 'package:eventy/shared/widgets/event_widgets/attendee_avatars.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TrendingEventCard extends StatelessWidget {
  const TrendingEventCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Container(
      width: DeviceUtils.getScaledWidth(context, 0.8),
      decoration: _buildCardDecoration(isDark),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final imageHight = constraints.maxHeight * 0.65;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -- TrendingEventCard Header
              // -- Image
              SizedBox(
                height: imageHight,
                // -- Top widgets
                child: Stack(
                  children: [
                    // -- Event Image
                    const _EventImageSection(),
                    // -- Top ribbon
                    const Positioned.fill(child: _TopRibbon()),
                  ],
                ),
              ),

              // -- TrendingEventCard Body
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // -- Event title
                      Expanded(
                        flex: 3,
                        child: FittedBox(
                          child: Text(
                            'Laugh with Vir Das / 20.12.2025',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      // -- Event Price
                      Flexible(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FittedBox(
                            child: Text(
                              'Rs 1000',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ),

                      // -- User whos join
                      Flexible(
                        flex: 4,
                        child: FittedBox(
                          child: AttendeeAvatars(
                            //width: constraints.maxWidth * 0.25,
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
              ),
            ],
          );
        },
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
  const _EventImageSection();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: AppStyles.eventCardRadius,
        child: CachedNetworkImage(
          imageUrl:
              'https://static.vecteezy.com/system/resources/thumbnails/041/388/388/small/ai-generated-concert-crowd-enjoying-live-music-event-photo.jpg',
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
  const _TopRibbon();

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
        IconButton(
          padding: const EdgeInsets.only(top: 20.0),
          icon: const Icon(Iconsax.archive_1, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }
}
