import 'package:flutter/material.dart';

class ResponsiveText {
  static double getResponsiveText(BuildContext context, double baseFontSize) {
    // calaculate the font size based on the screen size
    double scaleFactor = _getScaleFactor(context);
    double responsiveFontSize = baseFontSize * scaleFactor;

    double lowerBound = baseFontSize * 0.8;
    double upperBound = baseFontSize * 1.2;

    return responsiveFontSize.clamp(lowerBound, upperBound);
  }

  static double _getScaleFactor(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    if (screenWidth < 550) {
      return screenWidth / 550;
    } else if (screenWidth < 700) {
      return screenWidth / 700;
    } else {
      return screenWidth / 1200;
    }
  }
}

extension ResponsiveTextExtension on double {
  double responsiveText(BuildContext context) =>
      ResponsiveText.getResponsiveText(context, this);
}
