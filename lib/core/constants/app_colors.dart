import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primaryColor = Color(0xff01305A);
  static const mainblackColor = Color(0xFF121212);
  static const mainWhiteColor = Color(0xFFF5F7FA);
  static const secondaryColor = Color(0xffA00651);

  static const lightScaffoldBgColor = Color(0xfff4f4f4);
  static const darkScaffoldBgColor = Color(0xff000000);

  static const hintColor = Color(0xff948D8D);
  static const bodyTextColor = Color(0xff797676);

  static const primaryTextColor = Color(0xff000000);
  static const blueTextColor = Color(0xff0E377C);

  static const shadowhiteColot = Color(0xffF9F9F9);

  static const fillColor = Color(0xffD9D9D9);
  static const grayColor = Color(0xff666464);

  static const priceColor = Color(0xff014E1D);

  static const activeIconColor = Color(0xff0E377C);
  static const inactiveIconColor = Color(0xff8C8C8C);

  static const outlinedBtnBorderColor = Color(0xffADADAD);
  static const textFieldBorderColor = Color(0xff8C8C8C);

  static const eventOpacity = Color.fromARGB(255, 39, 13, 75);

  static const textBtnColor = Color(0xFF4b68ff);

  static const lightSliverAppBarColor = Color.fromARGB(255, 245, 245, 245);
  static const filtterIconColor = Color.fromARGB(251, 20, 20, 20);

  static const white = Color(0xffffffff);
  static const black = Color(0xff000000);
  static const navBarBlack = Color(0xFF232323);

  static LinearGradient interestedCardColor = const LinearGradient(
    colors: [Color(0xff5C2FC2), Color(0xff819FD3)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // static LinearGradient plushIconGradient = LinearGradient(
  //   colors: [Color(0xFF6464d7), Color(0xff819FD3), const Color.fromARGB(255, 135, 170, 233)],
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  // );

  static LinearGradient plushIconGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 220, 244, 255), 
      Color.fromARGB(255, 183, 171, 248),
      Color.fromARGB(255, 140, 137, 230),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient eventCardGradientColor = LinearGradient(
    colors: [
      const Color(0xff5C2FC2).withValues(alpha: 0.32),
      const Color(0xff819FD3).withValues(alpha: 0.3),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const dividerColor = Color(0xff808080);

  // Neutral Shades
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);

  static const Color confirmLocationColor = Color(0xFFD9D9D9);

  static const Color dark = Color(0xFF232323);

  static const Color light = Color(0xFFF6F6F6);

  static const Color eventyPrimaryColor = Color(0xFF6464d7);

  static const Color primary = Color(0xFF4b68ff);

  static const Color locationScreenColor = Color(0xFF6564db);

  static const Color dateFieldColor = Color(0xFFf5f6fa);
}
