import 'package:animations/animations.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/features/create_event/presentation/screens/create_event_screen.dart';
import 'package:eventy/features/home/presentation/screens/event_home_screen.dart';
import 'package:eventy/features/personalization/presentation/screens/profile_screen.dart';
import 'package:eventy/features/sceduale/presentation/screens/schedule_screen.dart';
import 'package:eventy/features/search/presentation/screens/search_secreen.dart';
import 'package:flutter/material.dart';

class NavigationScreenBody extends StatelessWidget {
  const NavigationScreenBody({super.key, required this.index});

  final int index;

  static final List<Widget> screens = [
    const EventHomeScreen(key: PageStorageKey('EventHomeScreen')),
    const SearchSecreen(key: PageStorageKey('SearchSecreen')),
    const CreateEventScreen(key: PageStorageKey('CreateEventScreen')),
    const ScheduleScreen(key: PageStorageKey('ScheduleScreen')),
    const ProfileScreen(key: PageStorageKey('ProfileScreen')),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 350),
      transitionBuilder:
          (
            Widget child,
            Animation<double> primaryAnimation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              fillColor: isDark ? Colors.black : Colors.white,
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
      child: screens[index],
    );
  }
}
