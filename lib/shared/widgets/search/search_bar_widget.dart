import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.showSearchBar,
    this.onChanged,
    this.hintText,
  });

  final ValueNotifier<bool> showSearchBar;
  final Function(String)? onChanged;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return ValueListenableBuilder<bool>(
      valueListenable: showSearchBar,
      builder: (BuildContext context, bool showSearchBar, Widget? child) {
        return ClipRect(
          child: AnimatedSize(
            duration: Duration(milliseconds: 450),
            curve: Curves.easeInOut,
            alignment: Alignment.centerLeft,
            clipBehavior: Clip.antiAlias,
            reverseDuration: Duration(milliseconds: 300),
            child: showSearchBar
                ? Container(
                    margin: EdgeInsets.only(top: 12.0),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.grayColor : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      onChanged: onChanged,
                      decoration: InputDecoration(
                        hintText: hintText ?? 'Type to search',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintStyle: TextStyle(
                          color: isDark ? Colors.white : Colors.grey,
                        ),
                        contentPadding: EdgeInsets.all(16),
                        prefixIcon: Icon(
                          Iconsax.search_normal,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.tune,
                            size: 26,
                            color: isDark
                                ? Colors.white
                                : AppColors.filtterIconColor,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
