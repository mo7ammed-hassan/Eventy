import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/features/home/presentation/manager/event_category_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EventCategoryTab extends StatelessWidget {
  const EventCategoryTab({
    super.key,
    required this.title,
    this.showIcon = false,
    this.onTap,
    required this.index,
  });
  final String title;
  final bool showIcon;
  final VoidCallback? onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      key: ValueKey(title),
      onTap: () => EventCategoryTabController.selectTab(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              // -- Category Name
              ValueListenableBuilder<int>(
                valueListenable:
                    EventCategoryTabController.selectedValueNotifier,
                builder: (context, selectedIndex, child) {
                  bool isSelected = selectedIndex == index;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: isSelected
                              ? isDark
                                    ? AppColors.white
                                    : AppColors.primaryColor
                              : Colors.grey,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w600,
                          fontSize: isSelected ? 15 : 14,
                        ),
                        child: Text(title),
                      ),

                      // -- Underline
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: isSelected ? _getTextWidth(title, context) : 0,
                          height: 1.8,
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white : Colors.black,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              // -- Category Icon
              if (showIcon)
                Padding(
                  padding: EdgeInsets.only(left: 6.0),
                  child: Icon(
                    Iconsax.medal_star, // magic_star5
                    color: isDark ? Colors.white : AppColors.filtterIconColor,
                    size: 18.0,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  double _getTextWidth(String text, BuildContext context) {
    final TextStyle style = Theme.of(
      context,
    ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700, fontSize: 15);

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.size.width - 10;
  }
}
