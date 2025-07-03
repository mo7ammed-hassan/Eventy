import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/shared/widgets/animated_widget/animated_fade_slide_list_item.dart';
import 'package:flutter/material.dart';

class AnimatedListLayout extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  const AnimatedListLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  State<AnimatedListLayout> createState() => _AnimatedListLayoutState();
}

class _AnimatedListLayoutState extends State<AnimatedListLayout> {
  final List<int> visibleItems = [];

  @override
  void initState() {
    super.initState();
    _animateAddItems();
  }

  void _animateAddItems() {
    for (int i = 0; i < widget.itemCount; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) {
          setState(() {
            if (!visibleItems.contains(i)) visibleItems.add(i);
          });
        }
      });
    }
  }

  void removeItem(int index) {
    setState(() {
      visibleItems.remove(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwSections, top: 6),
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),

      itemCount: widget.itemCount,
      separatorBuilder: (_, __) =>
          const SizedBox(height: AppSizes.spaceBtwItems),
      itemBuilder: (context, index) {
        return AnimatedFadeSlideListItem(
          isVisible: visibleItems.contains(index),
          onRemove: () => removeItem(index),
          child: widget.itemBuilder(context, index),
        );
      },
    );
  }
}
