import 'package:eventy/core/constants/app_sizes.dart';
import 'package:flutter/widgets.dart';

class CustomAnimatedListView<T> extends StatelessWidget {
  const CustomAnimatedListView({
    super.key,
    required this.items,
    required this.itemCount,
    required this.itemBuilder,
    this.separator,
    this.scrollDirection = Axis.vertical,
    this.translateOffset = 80,
    this.padding,
    this.animateOnlyOnFirstBuild = true,
    this.stopAnimationNearEnd = 3,
  });

  final List<T> items;
  final int itemCount;
  final Widget Function(BuildContext context, T? item, int index) itemBuilder;
  final Widget? separator;
  final Axis scrollDirection;
  final double translateOffset;
  final EdgeInsetsGeometry? padding;
  final bool animateOnlyOnFirstBuild;
  final int stopAnimationNearEnd;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: scrollDirection,
      padding: padding,
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
          duration: Duration(milliseconds: 500),
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
    );
  }
}



// class CustomAnimatedListView<T> extends StatelessWidget {
//   const CustomAnimatedListView({
//     super.key,
//     required this.itemCount,
//     required this.itemBuilder,
//     this.separator,
//     this.scrollDirection = Axis.vertical,
//     this.translateOffset = 80,
//     this.padding,
//     this.items,
//   });

//   final int itemCount;
//   final List<T>? items;
//   final Widget Function(BuildContext context, T? item, int index) itemBuilder;
//   final Widget? separator;
//   final Axis scrollDirection;
//   final double? translateOffset;
//   final EdgeInsetsGeometry? padding;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       scrollDirection: scrollDirection,
//       padding: padding,
//       itemCount: itemCount,
//       itemBuilder: (context, index) => TweenAnimationBuilder<double>(
//         tween: Tween(begin: 0, end: 1),
//         duration: Duration(milliseconds: 500 + index * 100),
//         builder: (context, value, child) {
//           return Opacity(
//             opacity: value,
//             child: Transform.translate(
//               offset: Offset(0, translateOffset! * (1 - value)),
//               child: child,
//             ),
//           );
//         },
//         child: itemBuilder(
//           context,
//           items != null && index < items!.length ? items![index] : null,
//           index,
//         ),
//       ),
//       separatorBuilder: (context, index) =>
//           separator ?? const SizedBox(height: AppSizes.spaceBtwEventCards),
//     );
//   }
// }