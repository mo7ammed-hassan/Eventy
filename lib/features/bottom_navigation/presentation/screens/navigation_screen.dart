import 'package:eventy/config/service_locator.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:eventy/features/bottom_navigation/presentation/widgets/navigation_screen_body.dart';
import 'package:eventy/features/bottom_navigation/presentation/widgets/custom_bottom_naviagtion_bar.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  NavigationScreenState createState() => NavigationScreenState();
}

class NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  final List<int> _navigationHistory = [0];

  @override
  void initState() {
    getIt.get<UserCubit>().getUserProfile();
    super.initState();
  }

  void _onTabTapped(int index) async {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
        _navigationHistory.add(index);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (_navigationHistory.isNotEmpty && !didPop) {
          setState(() {
            _navigationHistory.removeLast();
            _currentIndex = _navigationHistory.last;
          });
        }
      },
      child: Scaffold(
        body: NavigationScreenBody(index: _currentIndex),
        bottomNavigationBar: SafeArea(
          child: CustomBottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
          ),
        ),
      ),
    );
  }
}
