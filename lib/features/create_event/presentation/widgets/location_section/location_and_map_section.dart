import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_state.dart';
import 'package:eventy/features/create_event/presentation/widgets/location_section/map_section.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationAndMapSection extends StatelessWidget {
  const LocationAndMapSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDark ? AppColors.darkerGrey : AppColors.confirmLocationColor,
          width: 0.9,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          // Address Info Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on_outlined, size: 20),
              const SizedBox(width: AppSizes.md),

              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    BlocSelector<
                      CreateEventCubit,
                      CreateEventState,
                      LocationEntity
                    >(
                      selector: (CreateEventState state) {
                        return state is UpdateField<LocationEntity>
                            ? state.field
                            : context.read<CreateEventCubit>().location ??
                                  LocationEntity.empty();
                      },
                      builder: (context, location) {
                        return Text(
                          location.fullAddress,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          // Map Section
          const MapSection(),
        ],
      ),
    );
  }
}
