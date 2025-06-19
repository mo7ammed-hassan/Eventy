import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/storage/app_storage.dart';
import 'package:eventy/core/utils/dialogs/custom_dialogs.dart';
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

  bool show = false;

  void _onTabTapped(int index) async {
    await AppStorage.init();
    final showFlage = AppStorage.getBool('show');

    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
        _navigationHistory.add(index);
      });
    }

    await funyDialog(index, showFlage);
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

  Future<void> funyDialog(int index, bool? showFlage) async {
    if (index == 4 && showFlage == false) {
      final res = await CustomDialogs.showConfirmationDialog(
        iconData: Icons.sentiment_very_satisfied_sharp,
        iconColor: Colors.blue,
        textDirection: TextDirection.rtl,
        title: 'جوزنا الله ي رجاااااله 😂😂✌️ الله يصلح حالنا وحالكم يارب',
        buttonText: 'لا',
        confirmButtonText: 'امين يارب😂❤️',
      );

      if (res == true) {
        show = true;
        AppStorage.setValue('show', true);
        CustomDialogs.showConfirmationDialog(
          iconData: Icons.sentiment_very_satisfied,
          iconColor: Colors.blue,
          title: 'بحبك ف الله😂😂😂😂❤️',
          buttonText: 'الغاء',
          confirmButtonText: 'حبيبي😂❤️',
          textDirection: TextDirection.rtl,
        );
      } else {
        show = false;
        AppStorage.setValue('show', false);
        CustomDialogs.showConfirmationDialog(
          iconData: Icons.sentiment_very_dissatisfied,
          title: 'طول عمرك عبيط',
          buttonText: 'عبيط',
          confirmButtonText: 'اطلع ي عبيط',
          textDirection: TextDirection.rtl,
        );
      }
    }
  }
}
