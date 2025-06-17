import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/app_text_style.dart';

class CustomElevetedBtn extends StatelessWidget {
  const CustomElevetedBtn({
    super.key,
    required this.title,
    this.icon,
    this.color,
    this.textColor,
    this.onPressed,
  });
  final String title;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: DeviceUtils.screenWidth(context) * 0.5,
      height: 50,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Icon(
                    icon,
                    size: 22,
                    color: isDark ? Colors.white : AppColors.primaryColor,
                  )
                : const SizedBox.shrink(),
            const SizedBox(width: AppSizes.slg),
            Flexible(
              child: FittedBox(
                child: Text(
                  title,
                  style: AppTextStyle.textStyle17Medium(
                    context,
                  ).copyWith(color: textColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
