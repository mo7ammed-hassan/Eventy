import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/widgets/popups/loaders.dart';
import 'package:eventy/features/location/presentation/cubits/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LocationPermissionDialog extends StatefulWidget {
  const LocationPermissionDialog({super.key, required this.locationCubit});
  final LocationCubit locationCubit;

  @override
  State<LocationPermissionDialog> createState() =>
      _LocationPermissionDialogState();
}

class _LocationPermissionDialogState extends State<LocationPermissionDialog>
    with WidgetsBindingObserver {
  bool openedSettings = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // App Back to Foreground
    if (state == AppLifecycleState.resumed && openedSettings) {
      openedSettings = false;
      final resultOfCheck = await widget.locationCubit
          .recheckPermissionAndDetect();

      if (!mounted) return;

      if (context.mounted) {
        if (!resultOfCheck) {
          Navigator.pop(context);
          Loaders.warningSnackBar(
            title: 'Permission Still Denied',
            message: 'Location permission is still not granted.',
          );
        } else {
          Navigator.pop(context);
          Loaders.successSnackBar(
            title: 'Permission Granted',
            message: 'Location permission is granted.',
          );
        }
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.locationScreenColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            SvgPicture.asset(
              'assets/icons/location_point.svg',
              width: DeviceUtils.getScaledWidth(context, 0.25),
              height: DeviceUtils.getScaledHeight(context, 0.13),
            ),
            const SizedBox(height: 16),
            const Text(
              'You don\'t have location permission',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'To use this feature, please enable location access in your phone settings.',
              style: TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                openedSettings = true;
                await widget.locationCubit.openAppSettings();
              },
              child: const FittedBox(child: Text('Open App Settings')),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const FittedBox(child: Text('Close')),
            ),
          ],
        ),
      ),
    );
  }
}
