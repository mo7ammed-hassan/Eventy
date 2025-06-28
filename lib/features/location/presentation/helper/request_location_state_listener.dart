import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/dialogs/loading_dialogs.dart';
import 'package:eventy/core/widgets/popups/loaders.dart';
import 'package:eventy/features/location/presentation/cubits/location_state.dart';
import 'package:flutter/material.dart';

void handleLocationStateListener({
  required BuildContext context,
  required LocationState state,
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

  if (state.errorMessage != null) {
    LoadingDialogs.hideLoadingDialog(context);
    Loaders.warningSnackBar(
      title: 'Location Denied',
      message: state.errorMessage!,
    );
    return;
  }

  if (state.location != null || state.message != null) {
    // Loaders.successSnackBar(
    //   title: 'Location Granted',
    //   message: state.message ?? '',
    //   backgroundColor: const Color.fromARGB(255, 122, 120, 236),
    //   duration: 1,
    // );
    LoadingDialogs.hideLoadingDialog(context);
    Navigator.pop(context, state.location);
  }
}
