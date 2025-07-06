import 'package:eventy/config/routing/routes.dart';
import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/storage/secure_storage.dart';
import 'package:eventy/core/utils/helpers/app_context.dart';
import 'package:eventy/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:eventy/features/user_events/user_events_injection.dart';

class LogoutManager {
  static Future<void> forceLogout() async {
    AppContext.context.pushNamedAndRemoveUntilPage(Routes.loginScreen);

    final storage = getIt<SecureStorage>();
    await storage.deleteAllTokens();
    await storage.deleteUserId();

    unRegisterUserEventsCubits(getIt);
  }
}
