import 'package:eventy/core/utils/helpers/app_context.dart';
import 'package:flutter/material.dart';

class DeviceUtils {

  DeviceUtils._();

  // -- Screen Width and Height -- //
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // -- Screen Orientation -- //
  static Orientation getScreenOrientation() =>
      MediaQuery.of(AppContext.context).orientation;

  static getAppBarHeight() => AppBar().preferredSize.height;

  static getBottomNavigationBarHeight() => kBottomNavigationBarHeight;

  static getScaledHeight(BuildContext context, double d) {
    return screenHeight(context) * d;
  }

  static getScaledWidth(BuildContext context, double d) {
    return screenWidth(context) * d;
  }
}
