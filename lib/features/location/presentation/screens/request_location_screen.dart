import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/storage/app_storage.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/features/location/presentation/cubits/location_cubit.dart';
import 'package:eventy/features/location/presentation/cubits/location_state.dart';
import 'package:eventy/features/location/presentation/helper/request_location_state_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

class RequestLocationScreen extends StatelessWidget {
  const RequestLocationScreen({super.key, this.saveCurrentLocation = true, this.locationCubit});
  final bool saveCurrentLocation;
  final LocationCubit? locationCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locationCubit?? LocationCubit(),
      child: BlocListener<LocationCubit, LocationState>(
        listener: (context, state) => handleLocationStateListener(
          context: context,
          state: state,
          cubit: context.read<LocationCubit>(),
        ),
        child: Scaffold(
          backgroundColor: AppColors.locationScreenColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                getIt<AppStorage>().setBool('location_permission_denied', true);
                Navigator.pop(context, null);
              },
              icon: Icon(Iconsax.arrow_left, size: 24, color: Colors.white),
            ),
          ),

          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.defaultPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: SvgPicture.asset('assets/icons/location.svg'),
                  ),
                  SizedBox(height: DeviceUtils.getScaledHeight(context, 0.05)),

                  Text(
                    'Location Access',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections - 4),

                  Text(
                    'Allow Eventy to access your location to find events near you. This data will not be shared with any third parties.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: DeviceUtils.getScaledHeight(context, 0.14)),

                  // Button
                  SizedBox(
                    width: DeviceUtils.getScaledWidth(context, 0.4),
                    child: Builder(
                      builder: (context) {
                        return ElevatedButton(
                          onPressed: () =>
                              context.read<LocationCubit>().detectUserLocation(
                                saveCurrentLocation: saveCurrentLocation,
                              ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide(color: Colors.white),
                          ),
                          child: FittedBox(
                            child: const Text(
                              'Allow Location',
                              style: TextStyle(color: AppColors.blueTextColor),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: DeviceUtils.getScaledHeight(context, 0.17)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
