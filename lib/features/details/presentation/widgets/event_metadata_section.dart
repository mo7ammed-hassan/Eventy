import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/features/details/presentation/widgets/details_header_section.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventMetadataSection extends StatelessWidget {
  const EventMetadataSection({super.key, required this.event});

  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = HelperFunctions.isDarkMode(context);
    final eventDate = DateFormat('EEEE, MMMM d, y').format(event.date);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.name,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white70 : AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),

        _BuildDetailsRow(
          key: ValueKey(event.date),
          icon: Icons.calendar_month,
          text: '$eventDate • ${event.time}',
        ),
        const SizedBox(height: AppSizes.lg),
        _BuildDetailsRow(
          key: ValueKey(event.location.address),
          icon: Icons.location_pin,
          text: event.location.address ?? 'Unknown',
        ),
        const SizedBox(height: AppSizes.lg),
        _BuildDetailsRow(
          key: ValueKey(event.price),
          icon: Icons.money,
          text:
              (event.paid == true && event.price != '0.0') &&
                  event.price != '0' &&
                  event.price != ''
              ? '${event.price} EGP'
              : 'Free',
        ),
        const SizedBox(height: AppSizes.lg),
        _BuildDetailsRow(
          key: ValueKey(event.type),
          icon: Icons.group,
          text: '${event.type} Event',
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),

        /// --- Category ---
        DetailsHeaderSection(title: 'Category'),
        const SizedBox(height: AppSizes.spaceBtwTextField / 2),
        Chip(
          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
          label: Text(
            event.category[0].toUpperCase() + event.category.substring(1),
          ),
          backgroundColor: isDark
              ? AppColors.eventyPrimaryColor
              : AppColors.eventyPrimaryColor.withValues(alpha: 0.2),
          labelStyle: TextStyle(
            color: isDark ? Colors.white : AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),

        /// --- Description ---
        DetailsHeaderSection(title: 'About this event'),
        const SizedBox(height: AppSizes.spaceBtwTextField / 2),
        Text(
          event.description,
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.5,
            color: isDark ? Colors.grey : Colors.black,
          ),
        ),
      ],
    );
  }
}

class _BuildDetailsRow extends StatelessWidget {
  const _BuildDetailsRow({super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);

    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: isDarkMode ? Colors.blueGrey : AppColors.primaryColor,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isDarkMode ? Colors.grey : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
