import 'package:eventy/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class CustomAnimatedSliverListView<T> extends StatelessWidget {
  const CustomAnimatedSliverListView({
    super.key,
    required this.items,
    required this.itemCount,
    required this.itemBuilder,
    this.separator,
    this.translateOffset = 80,
    this.padding,
    this.animateOnlyOnFirstBuild = true,
    this.stopAnimationNearEnd = 3,
  });

  final List<T> items;
  final int itemCount;
  final Widget Function(BuildContext context, T? item, int index) itemBuilder;
  final double translateOffset;
  final EdgeInsetsGeometry? padding;
  final Widget? separator;
  final bool animateOnlyOnFirstBuild;
  final int stopAnimationNearEnd;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding ?? EdgeInsets.zero,
      sliver: SliverList.separated(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final item = index < items.length ? items[index] : null;
          final child = itemBuilder(context, item, index);

          final bool shouldAnimateItem =
              animateOnlyOnFirstBuild &&
              (itemCount <= stopAnimationNearEnd ||
                  index < itemCount - stopAnimationNearEnd);

          if (!shouldAnimateItem || item == null) return child;

          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.5, end: 1),
            duration: Duration(milliseconds: 400 + index * 80),
            builder: (context, value, animatedChild) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, translateOffset * (1 - value)),
                  child: animatedChild,
                ),
              );
            },
            child: child,
          );
        },
        separatorBuilder: (context, index) =>
            separator ?? const SizedBox(height: AppSizes.spaceBtwEventCards),
      ),
    );
  }
}
