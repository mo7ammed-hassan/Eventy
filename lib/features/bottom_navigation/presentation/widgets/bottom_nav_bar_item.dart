import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final activeColor = const Color(0xFF7165E3);
    final inactiveColor = Colors.grey.shade500;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 300),
            tween: Tween<double>(
              begin: isActive ? 1.0 : 0.8,
              end: isActive ? 1.1 : 0.9,
            ),
            builder: (context, scale, child) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isActive
                    ? isDark
                          ? activeColor.withValues(alpha: 0.2)
                          : activeColor.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Transform.scale(
                scale: scale,
                child: Icon(
                  icon,
                  color: isActive
                      ? isDark
                            ? Colors.white
                            : activeColor
                      : inactiveColor,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),

        // -- Underline
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: isActive ? 18 : 0,
          height: 2,
          decoration: BoxDecoration(
            color: activeColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
