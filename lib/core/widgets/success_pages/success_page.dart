import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/text_strings.dart';

class SuccessPage extends StatelessWidget {
  final String image, title, subtitle;
  final VoidCallback? onPressed;
  final bool json;
  const SuccessPage({
    super.key,
    this.image = '',
    this.title = '',
    this.subtitle = '',
    this.onPressed,
    this.json = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
              json
                  ? Lottie.asset(
                      image,
                      width: MediaQuery.of(context).size.width * 0.6,
                    )
                  : Image.asset(
                      image,
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              _continueButton(context),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _continueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text(AppStrings.tContinue),
      ),
    );
  }
}

class TSpacingStyles {
  TSpacingStyles._();

  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: AppSizes.appBarHeight,
    left: AppSizes.defaultPadding,
    right: AppSizes.defaultPadding,
    bottom: AppSizes.defaultPadding,
  );
}
