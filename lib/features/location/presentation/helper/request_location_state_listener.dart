import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/dialogs/loading_dialogs.dart';
import 'package:eventy/core/widgets/popups/loaders.dart';
import 'package:eventy/features/location/presentation/cubits/location_cubit.dart';
import 'package:eventy/features/location/presentation/cubits/location_state.dart';
import 'package:eventy/features/location/presentation/widgets/location_permission_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void handleLocationStateListener({
  required BuildContext context,
  required LocationState state,
  required LocationCubit cubit,
}) async {
  if (state.isLoading) {
    LoadingDialogs.showLoadingDialog(
      context,
      color: AppColors.white,
      enableConstraints: true,
      enabledBackground: true,
    );
    return;
  }

  if (state.errorMessage != null && state.permission == null) {
    LoadingDialogs.hideLoadingDialog(context);
    Loaders.warningSnackBar(
      title: 'Location Denied',
      message: state.errorMessage!,
    );
    return;
  }

  if ((state.permission == LocationPermission.denied ||
      state.permission == LocationPermission.deniedForever)) {
    LoadingDialogs.hideLoadingDialog(context);
    showLocationPermissionDialog(context, cubit);
    return;
  }

  if (state.location != null) {
    LoadingDialogs.hideLoadingDialog(context);
    Navigator.pop(context, state.location);
    return;
  }
}

void showLocationPermissionDialog(BuildContext context, cubit) {
  showGeneralDialog(
    context: context,
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) =>
        LocationPermissionDialog(locationCubit: cubit),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
        child: child,
      );
    },
  );
}
