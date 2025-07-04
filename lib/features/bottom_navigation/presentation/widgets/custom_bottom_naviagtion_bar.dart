import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/features/bottom_navigation/presentation/widgets/bottom_nav_bar_item.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/features/bottom_navigation/presentation/widgets/bottom_nav_bar_plus_icon.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 8, bottom: 4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.mainblackColor : Colors.white,
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black : Colors.grey.shade200,
            offset: const Offset(0, -3),
            blurRadius: 6.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),

      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavItem(
                icon: Iconsax.home,
                isActive: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              NavItem(
                icon: Iconsax.search_normal,
                isActive: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(),
              ),
              NavItem(
                icon: Iconsax.calendar,
                isActive: currentIndex == 3,
                onTap: () => onTap(3),
              ),
              NavItem(
                icon: Iconsax.user,
                isActive: currentIndex == 4,
                onTap: () => onTap(4),
              ),
            ],
          ),
          BottomNavBarPlusIcon(onTap: () => onTap(2)),
        ],
      ),
    );
  }
}







// class CustomBottomNavigationBar extends StatelessWidget {
//   const CustomBottomNavigationBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return BlocBuilder<BottomNavCubit, int>(
//       builder: (context, state) {
//         return Stack(
//           clipBehavior: Clip.none,
//           children: [
//             NavigationBar(
//               height: 62,
//               selectedIndex: state,
//               backgroundColor: isDark ? AppColors.mainblackColor : Colors.white,
//               onDestinationSelected: (index) {
//                 context.read<BottomNavCubit>().changeTab(index);
//               },
//               destinations: [
//                 NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
//                 NavigationDestination(
//                   icon: Icon(Iconsax.search_normal),
//                   label: "Search",
//                 ),
//                 NavigationDestination(
//                   icon: Container(
//                     decoration: ShapeDecoration(
//                       shape: const CircleBorder(),
//                       color: isDark ? AppColors.mainblackColor : Colors.white,
//                     ),
//                   ),
//                   label: '',
//                 ),
//                 NavigationDestination(
//                   icon: Icon(Iconsax.calendar),
//                   label: "Sceduale",
//                 ),
//                 NavigationDestination(
//                   icon: Icon(Iconsax.user),
//                   label: "Profile",
//                 ),
//               ],
//             ),
//             const BottomNavBarPlusIcon(),
//           ],
//         );
//       },
//     );
//   }
// }