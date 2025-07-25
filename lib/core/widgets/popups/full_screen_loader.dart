import 'package:eventy/features/location/presentation/screens/request_location_screen.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/helpers/app_context.dart';
import 'package:eventy/core/widgets/loaders/animation_loader.dart';

/// A utility class for managing a full-screen loading dialog.
class TFullScreenLoader {
  /// Open a full-screen loading dialog with a given text and animation.
  /// This method doesn't return anything.
  ///
  /// Parameters:
  ///   - text: The text to be displayed in the loading dialog.
  ///   - animation: The Lottie animation to be shown.
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      useSafeArea: false,
      context: AppContext
          .overlayContext, // Use Get.overlayContext for overlay dialogs
      barrierDismissible:
          false, // The dialog can't be dismissed by tapping outside it
      builder: (_) => PopScope(
        canPop: false, // Disable popping with the back button
        child: Container(
          color: Theme.of(AppContext.context).brightness == Brightness.dark
              ? Colors.black
              : AppColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(height: 250), // Adjust the spacing as needed
              TAnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  /// Stop the currently open loading dialog.
  /// This method doesn't return anything.
  static void stopLoading() {
    Navigator.of(
      AppContext.overlayContext,
      rootNavigator: true,
    ).pop(null); // Close the dialog using the Navigator
  }

  static Future<LocationEntity?> openLocationAccessWidget(BuildContext context) {
    return showDialog<LocationEntity?>(
      context: context,
      useSafeArea: false,
      animationStyle: AnimationStyle(
        reverseDuration: Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn,
      ),
      builder: (_) => const RequestLocationScreen(),
    );
  }

  // close
}
