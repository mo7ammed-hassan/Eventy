import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/details/presentation/widgets/event_action_buttons.dart';
import 'package:eventy/features/details/presentation/widgets/event_header.dart';
import 'package:eventy/features/details/presentation/widgets/event_map_section.dart';
import 'package:eventy/features/details/presentation/widgets/event_metadata_section.dart';
import 'package:eventy/features/details/presentation/widgets/event_organization_section.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as EventEntity;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          /// Header
          EventHeader(imageUrl: event.image),

          /// Body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.defaultPadding,
                vertical: AppSizes.spaceBtwSections,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EventMetadataSection(event: event),
                  const SizedBox(height: AppSizes.spaceBtwSections),

                  EventMapSection(location: event.location),
                  const SizedBox(height: AppSizes.spaceBtwSections),

                  EventOrganizerSection(
                    hostCompany: event.host,
                    category: event.category,
                    imageUrl: event.image,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: EventActionButtons(event: event),
    );
  }
}
