import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyEventList extends StatelessWidget {
  const EmptyEventList({super.key, this.height, this.title});
  final double? height;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (height == null)
          SizedBox(height: DeviceUtils.getScaledHeight(context, 0.04)),

        Flexible(
          child: SizedBox(
            height: height,
            child: Lottie.asset(AppImages.pencilAnimation),
          ),
        ),

        const SizedBox(height: AppSizes.lg),

        Text(
          title ?? 'There are no events to show',
          style: height == null
              ? Theme.of(context).textTheme.bodyMedium
              : Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13),
        ),

        const SizedBox(height: kTextTabBarHeight),
      ],
    );
  }
}
