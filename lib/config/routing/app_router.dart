import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_constants.dart';
import 'package:eventy/core/storage/app_storage.dart';
import 'package:eventy/core/storage/secure_storage.dart';
import 'package:eventy/features/home/presentation/screens/event_home_screen.dart';
import 'package:eventy/features/location/presentation/screens/request_location_screen.dart';
import 'package:eventy/features/onboarding/screens/onboarding_screen.dart';
import 'package:eventy/features/personalization/presentation/screens/edit_personal_info_screen.dart';
import 'package:eventy/features/personalization/presentation/screens/profile_screen.dart';
import 'package:eventy/features/personalization/presentation/screens/settings_screen.dart';
import 'package:eventy/features/user_events/presentation/screens/created_events_screen.dart';
import 'package:eventy/features/user_events/presentation/screens/favorite_events_screen.dart';
import 'package:eventy/features/user_events/presentation/screens/pending_events_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventy/config/routing/routes.dart';
import 'package:eventy/features/auth/presentation/cubits/forget_password/reset_password_cubit.dart';
import 'package:eventy/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:eventy/features/auth/presentation/screens/otp_screen.dart';
import 'package:eventy/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:eventy/features/chat_bot/screens/chat_bot_screen.dart';
import 'package:eventy/features/create_event/presentation/screens/create_event_screen.dart';
import 'package:eventy/features/auth/presentation/screens/login_screen.dart';
import 'package:eventy/features/auth/presentation/screens/signup_screen.dart';
import 'package:eventy/features/search/presentation/screens/search_secreen.dart';
import 'package:eventy/features/sceduale/presentation/screens/schedule_screen.dart';
import 'package:eventy/features/bottom_navigation/presentation/screens/navigation_screen.dart';

class AppRouter {
  const AppRouter();

  static final Map<String, Widget Function(BuildContext)> _routes = {
    /// --- Welcome Screen ---
    Routes.onboardingScreen: (_) => const OnboardingScreen(),

    /// --- Auth Screen ---
    Routes.loginScreen: (_) => const LoginScreen(),
    Routes.signupScreen: (_) => const SignupScreen(),
    Routes.resetPasswordScreen: (_) => BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: const ResetPasswordScreen(),
    ),
    Routes.forgetPasswordScreen: (_) => BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: const ForgetPasswordScreen(),
    ),
    Routes.otpVerificationScreen: (_) => const OtpScreen(),

    /// --- Navigation Screen ---
    Routes.navigationScreen: (_) => const NavigationScreen(),
    Routes.eventHomeScreen: (_) => const EventHomeScreen(),
    Routes.searchScreen: (_) => const SearchSecreen(),
    Routes.scheduleScreen: (_) => const ScheduleScreen(),
    Routes.createEventScreen: (_) => const CreateEventScreen(),

    /// --- User Events Screen ---
    Routes.favoriteScreen: (_) => const FavoriteEventsScreen(),
    Routes.pendingEvenstScreen: (_) => const PendingEventsScreen(),
    Routes.createdEventScreen: (_) => const CreatedEventsScreen(),

    /// --- Other Screen ---
    Routes.chatBotScreen: (_) => const ChatBotScreen(),
    Routes.requestLocationScreen: (_) => const RequestLocationScreen(),

    /// --- Personalization Screen ---
    Routes.profileScreen: (_) => const ProfileScreen(),
    Routes.editPersonalInfoScreen: (_) => const EditPersonalInfoScreen(),
    Routes.settingsScreen: (_) => const SettingsScreen(),
  };

  static Future<String> getInitialRoute() async {
    final secureStorage = getIt.get<SecureStorage>();
    final appStorage = getIt<AppStorage>();

    bool? onBoardingShown = appStorage.getBool(kOnBoardingShown);
    final accessToken = await secureStorage.getAccessToken();

    if (!onBoardingShown) {
      return Routes.onboardingScreen;
    } else {
      return accessToken != null ? Routes.navigationScreen : Routes.loginScreen;
    }
  }

  Route<dynamic>? generateRoute(RouteSettings settings) {
    final pageBuilder = _routes[settings.name];

    if (pageBuilder != null) {
      return settings.name == Routes.navigationScreen
          ? scaleTransitionNavigation(pageBuilder, settings: settings)
          : systemNavigation(pageBuilder, settings: settings);
    }

    return null;
  }

  Route? systemNavigation(
    Widget Function(BuildContext) pageBuilder, {
    RouteSettings? settings,
  }) {
    final isIOS = defaultTargetPlatform == TargetPlatform.iOS;

    return isIOS
        ? CupertinoPageRoute(builder: pageBuilder, settings: settings)
        : MaterialPageRoute(builder: pageBuilder, settings: settings);
  }

  PageRouteBuilder<dynamic> scaleTransitionNavigation(
    Widget Function(BuildContext) pageBuilder, {
    RouteSettings? settings,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) =>
          pageBuilder(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return ScaleTransition(scale: curvedAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 400),
    );
  }
}
