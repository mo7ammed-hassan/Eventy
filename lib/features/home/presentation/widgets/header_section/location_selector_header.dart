import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/text_strings.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/features/location/presentation/screens/request_location_screen.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_cubit.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_state.dart';
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
          children: [const _LocationSelector(), const ProfileAvatar()],
        ),
      ),
    );
  }
}

class _LocationSelector extends StatelessWidget {
  const _LocationSelector();

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
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
            BlocSelector<UserCubit, UserState, LocationEntity>(
              selector: (state) {
                return state.location ??
                    userCubit.location ??
                    LocationEntity.empty();
              },
              builder: (context, state) {
                return FittedBox(
                  child: Text(
                    state.country ?? 'No Location',
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
              onTap: () async {
                final res = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RequestLocationScreen()),
                );

                if (res != null) {
                  userCubit.updateLocation(res);
                }
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
