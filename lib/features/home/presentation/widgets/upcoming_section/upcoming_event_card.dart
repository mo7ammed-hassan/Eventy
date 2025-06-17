import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/app_styles.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/core/widgets/shimmer/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UpcomingEventCard extends StatelessWidget {
  const UpcomingEventCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHight = constraints.maxHeight * 0.66;
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.dark : Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.eventCardRadius),
            boxShadow: AppStyles.eventCardShadow(isDark),
          ),
          child: Column(
            children: [
              // -- Event Image
              Flexible(
                flex: 2,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: AppStyles.eventCardRadius,
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://static.vecteezy.com/system/resources/thumbnails/041/388/388/small/ai-generated-concert-crowd-enjoying-live-music-event-photo.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: imageHight,
                        placeholder: (context, url) => const ShimmerWidget(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),

                    // -- Top ribbon
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(
                          Iconsax.archive_1,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),

              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // -- Event title
                      FittedBox(
                        child: Text(
                          'Tam Impact Festival 2023',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),

                      // -- Event Price
                      FittedBox(
                        child: Text(
                          'Surbuna, Surabaya',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontSize: 12.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
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
      },
    );
  }
}
