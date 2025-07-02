import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/text_strings.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/features/location/presentation/cubits/location_cubit.dart';
import 'package:eventy/features/location/presentation/cubits/location_state.dart';
import 'package:eventy/features/location/presentation/screens/request_location_screen.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:eventy/shared/widgets/event_widgets/profile_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationSelectorHeader extends StatelessWidget {
  const LocationSelectorHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocProvider(
              create: (context) => getIt.get<LocationCubit>(),
              child: const _LocationSelector(),
            ),
            const ProfileAvatar(),
          ],
        ),
      ),
    );
  }
}

class _LocationSelector extends StatelessWidget {
  const _LocationSelector();

  @override
  Widget build(BuildContext context) {
    final locationCubit = context.read<LocationCubit>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: DeviceUtils.screenWidth(context) * 0.5,
          child: Text(
            AppStrings.youAreHere,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: Colors.grey),
          ),
        ),

        // -- Location Selector
        Row(
          children: [
            // -- User Current Location
            BlocSelector<LocationCubit, LocationState, LocationEntity>(
              selector: (state) => state.location ?? locationCubit.location,

              builder: (context, state) {
                return FittedBox(
                  child: Text(
                    state.country ?? 'Egypt',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 6),

            // -- Dropdown Icon
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        RequestLocationScreen(locationCubit: locationCubit),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 28,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
