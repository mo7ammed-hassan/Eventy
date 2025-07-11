import 'package:eventy/config/routing/routes.dart';
import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/storage/secure_storage.dart';
import 'package:eventy/core/utils/helpers/app_context.dart';
import 'package:eventy/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:eventy/features/home/presentation/cubits/home_cubit.dart';
import 'package:eventy/features/search/presentation/cubits/search_cubit.dart';
import 'package:eventy/features/user_events/user_events_injection.dart';

class LogoutManager {
  static bool _isLoggingOut = false;

  static Future<void> forceLogout() async {
    if (_isLoggingOut) return;
    _isLoggingOut = true;

    AppContext.context.pushNamedAndRemoveUntilPage(Routes.loginScreen);

    final storage = getIt<SecureStorage>();
    await storage.clearAuthData();

    await resetUserCubits();
    await getIt.resetLazySingleton<HomeCubit>();
    await getIt.resetLazySingleton<SearchCubit>();

    _isLoggingOut = false;
  }
}
