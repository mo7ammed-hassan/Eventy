import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class LoadingDialogs {
  static void showLoadingDialog(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black38,
      builder: (context) => PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(
            color: isDark ? AppColors.white : Colors.blue,
          ),
        ),
      ),
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
