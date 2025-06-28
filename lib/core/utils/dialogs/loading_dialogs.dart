import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class LoadingDialogs {
  static void showLoadingDialog(
    BuildContext context, {
    Color? color,
    Color? backgroundColor,
    bool enableConstraints = false,
    bool enabledBackground = false,
  }) {
    final isDark = HelperFunctions.isDarkMode(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black38,
      builder: (context) => PopScope(
        canPop: false,
        child: Center(
          child: enabledBackground
              ? Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.locationScreenColor.withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                  ),
                  child: FittedBox(
                    child: CircularProgressIndicator.adaptive(
                      constraints: enableConstraints
                          ? BoxConstraints(
                              maxWidth: 35,
                              maxHeight: 35,
                              minWidth: 35,
                              minHeight: 35,
                            )
                          : null,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDark ? AppColors.white : Colors.blue,
                      ),
                    ),
                  ),
                )
              : CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isDark ? AppColors.white : Colors.blue,
                  ),
                ),
        ),
      ),
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    final navigator = Navigator.of(context, rootNavigator: true);

    if (navigator.canPop()) {
      navigator.pop();
    } else {
      debugPrint("🛑 Tried to pop, but nothing to pop.");
    }
  }
}
