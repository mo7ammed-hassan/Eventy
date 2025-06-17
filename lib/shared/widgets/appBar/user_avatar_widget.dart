import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/app_colors.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({
    super.key,
    required this.userImageUrl,
    this.isNetworkImage = false,
    this.minRadius,
    this.maxRadius,
    this.showBorder = true,
    this.borderColor = AppColors.primaryTextColor,
  });
  final String userImageUrl;
  final bool isNetworkImage;
  final double? minRadius;
  final double? maxRadius;
  final bool showBorder;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.sm),
      decoration: ShapeDecoration(
        shape: CircleBorder(
          side: showBorder
              ? BorderSide(width: 2, color: borderColor)
              : BorderSide.none,
        ),
      ),
      child: CircleAvatar(
        minRadius: minRadius ?? 12,
        maxRadius: maxRadius ?? 15,
        backgroundColor: AppColors.bodyTextColor,
        backgroundImage: isNetworkImage
            ? CachedNetworkImageProvider(userImageUrl)
            : AssetImage(userImageUrl),
      ),
    );
  }
}
