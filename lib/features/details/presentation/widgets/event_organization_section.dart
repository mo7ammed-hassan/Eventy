import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/core/widgets/shimmer/shimmer_widget.dart';
import 'package:eventy/features/details/presentation/widgets/details_header_section.dart';
import 'package:eventy/features/personalization/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class EventOrganizerSection extends StatelessWidget {
  const EventOrganizerSection({
    super.key,
    required this.host,
    required this.category,
  });

  final UserEntity host;
  final String category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = HelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DetailsHeaderSection(title: 'Organizer'),
        const SizedBox(height: AppSizes.spaceBtwTextField),
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: host.imageUrl,
              imageBuilder: (_, imageProvider) =>
                  CircleAvatar(radius: 20, backgroundImage: imageProvider),
              placeholder: (_, __) => const ShimmerWidget(
                width: 40,
                height: 40,
                shapeBorder: CircleBorder(),
              ),
              errorWidget: (_, __, ___) => const CircleAvatar(
                radius: 20,
                child: Icon(Icons.error, size: 18),
              ),
            ),
            const SizedBox(width: AppSizes.slg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    host.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    host.email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
