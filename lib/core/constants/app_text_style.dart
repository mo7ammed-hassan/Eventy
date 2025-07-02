import 'package:flutter/material.dart';
import 'package:eventy/core/utils/helpers/responsive/responsive_text.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle textStyle32Bold(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge!;
  }

  static TextStyle textStyle20Bold(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontSize: 20.0.responsiveText(context),
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle textStyle13SemiBold(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 13.0.responsiveText(context),
      );

  static TextStyle textStyle18ExtraBold(BuildContext context) => Theme.of(
    context,
  ).textTheme.titleLarge!.copyWith(fontSize: 18.0, fontWeight: FontWeight.w500);

  static TextStyle textStyle20Medium(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!;

  static TextStyle textStyle32Medium(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!;

  static TextStyle textStyle24Medium(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall!;

  static TextStyle textStyle14Regular(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!;

  static TextStyle textStyle16Regular(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!;

  static TextStyle textStyle16Medium(BuildContext context) => Theme.of(
    context,
  ).textTheme.bodyLarge!.copyWith(fontSize: 14.0.responsiveText(context));

  static TextStyle defaultCalendarTextStyle(BuildContext context) => Theme.of(
    context,
  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500);

  static TextStyle textStyle16Bold(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontSize: 16.0.responsiveText(context),
        fontWeight: FontWeight.w700,
      );

  static TextStyle textStyle17Medium(BuildContext context) => Theme.of(
    context,
  ).textTheme.headlineSmall!.copyWith(fontSize: 17.0.responsiveText(context));

  static TextStyle textStyle12Regular(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!;

  static TextStyle textStyle15Regular(BuildContext context) => Theme.of(
    context,
  ).textTheme.bodyMedium!.copyWith(fontSize: 15.0.responsiveText(context));

  static TextStyle textStyle13Light(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w300,
        fontSize: 13.0.responsiveText(context),
        color: Colors.white,
      );
  static TextStyle textStyle14Light(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w300,
        fontSize: 14.0.responsiveText(context),
        color: Colors.white,
      );
}
