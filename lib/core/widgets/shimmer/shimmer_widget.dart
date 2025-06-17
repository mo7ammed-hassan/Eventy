import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double? width, height;
  final ShapeBorder? shapeBorder;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color? baseColor;

  const ShimmerWidget({
    super.key,
    this.width = double.infinity,
    this.height,
    this.shapeBorder,
    this.padding,
    this.margin,
    this.child, this.baseColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[600]! : Colors.grey[100]!,
      period: const Duration(milliseconds: 1550),
      child: Container(
        padding: padding,
        width: width,
        height: height ?? 20,
        margin: margin,
        decoration: ShapeDecoration(
          color: Colors.grey,
          shape:
              shapeBorder ??
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: child,
      ),
    );
  }
}
