import 'package:eventy/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:eventy/app.dart';
import 'package:eventy/config/routing/app_router.dart';
import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/storage/app_storage.dart';

Future<void> main() async {
  // Flutter Binding
  WidgetsFlutterBinding.ensureInitialized();

  // Splash Screen
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );

  // Load Environment Variables
  await dotenv.load(fileName: '.env');

  // Initialize Gemini API
  Gemini.init(apiKey: dotenv.get('GEMINI_API_KEY', fallback: ''));

  // Initialize Service Locator
  await initializeDependencies();

  // Initialize Shared Preferences & Storage
  await getIt.get<AppStorage>().init();

  // Remove Splash Screen after initialization
  FlutterNativeSplash.remove();
  // Load saved theme before running the app
  await ThemeService.init();

  // Entry Point
  final initialRoute = await AppRouter.getInitialRoute();

  // Start the App with ThemeProvider
  runApp(MyApp(appRouter: AppRouter(), initialRoute: initialRoute));
}
