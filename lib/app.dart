import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/services/system_ui_service.dart';
import 'package:eventy/core/services/theme_service.dart';
import 'package:eventy/core/utils/helpers/app_focus_handler.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/theme/app_theme.dart';
import 'package:eventy/config/routing/app_router.dart';
import 'package:eventy/core/utils/helpers/app_context.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final String initialRoute;
  const MyApp({super.key, required this.appRouter, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    SystemUiService.setSystemUIOverlayStyle(context);
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeService.themeNotifier,
      builder: (context, currentThemeMode, child) {
        return BlocProvider.value(
          value: getIt.get<UserCubit>(),
          child: AppFocusHandler(
            child: MaterialApp(
              title: 'Smart Event Planner',
              debugShowCheckedModeBanner: false,
              navigatorKey: AppContext.navigatorKey,
              themeMode: ThemeMode.system,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              locale: const Locale('en'),
              supportedLocales: const [Locale('en')],
              onGenerateRoute: (settings) => appRouter.generateRoute(settings),
              initialRoute: initialRoute,
            ),
          ),
        );
      },
    );
  }
}
