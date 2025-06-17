import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  final String? imageUrl;
  final double? width, height;
  final double borderRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit fit;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool aplayImageRaduis, isNetworkImage;

  const RoundedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius = AppSizes.eventCardRadius,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.onTap,
    this.aplayImageRaduis = true,
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: aplayImageRaduis
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Image(
            image: (isNetworkImage && imageUrl != null)
                ? CachedNetworkImageProvider(imageUrl!)
                : AssetImage(imageUrl ?? AppImages.defaultImage),
            fit: fit,
          ),
        ),
      ),
    );
  }
}
