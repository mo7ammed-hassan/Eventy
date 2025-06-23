import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
    this.onTap,
  });
  final String category;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.lg, bottom: AppSizes.md),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          //padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 13.0),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.04,
            vertical: 13.0,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.secondaryColor
                : isDark
                ? AppColors.dark
                : Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                offset: Offset(0, isDark ? 1 : 2),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Radio button
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                ),
              ),
              const SizedBox(width: AppSizes.slg),
              Flexible(
                child: FittedBox(
                  child: Text(
                    category,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : isDark
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
