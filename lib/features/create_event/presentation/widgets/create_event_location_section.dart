import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';
import 'package:eventy/features/create_event/presentation/widgets/location_section/location_and_map_section.dart';
import 'package:eventy/features/location/presentation/screens/request_location_screen.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventLocationSection extends StatelessWidget {
  const CreateEventLocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateEventCubit>();
    return Column(
      children: [
        // Location Map Section
        const LocationAndMapSection(),
        const SizedBox(height: AppSizes.spaceBtwSections),

        // Trigger Location
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              side: BorderSide.none,
            ),
            onPressed: () async {
              final LocationEntity? newLocation = await Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (_) => const RequestLocationScreen(
                        saveCurrentLocation: false,
                      ),
                    ),
                  );

              newLocation != null ? cubit.updateLocation(newLocation) : null;
            },
            icon: Flexible(child: Icon(Icons.location_on_outlined, size: 18)),
            label: FittedBox(
              child: Text(
                'Use Current Location',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),
      ],
    );
  }
}
