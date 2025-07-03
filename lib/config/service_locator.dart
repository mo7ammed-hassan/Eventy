import 'package:eventy/core/storage/app_storage.dart';
import 'package:eventy/features/create_event/event_injection.dart';
import 'package:eventy/features/location/presentation/cubits/location_cubit.dart';
import 'package:eventy/features/personalization/personalization_injection.dart';
import 'package:eventy/features/search/presentation/cubits/search_cubit.dart';
import 'package:eventy/features/user_events/user_events_injection.dart';
import 'package:get_it/get_it.dart';
import 'package:eventy/core/network/api_client.dart';
import 'package:eventy/core/network/api_service.dart';
import 'package:eventy/core/storage/secure_storage.dart';
import 'package:eventy/features/auth/auth_injection.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // ---------- Core ----------
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  getIt.registerLazySingleton<ApiServices>(
    () => ApiServices(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<SecureStorage>(() => SecureStorage());
  getIt.registerLazySingleton<AppStorage>(() => AppStorage());

  getIt.registerFactory<LocationCubit>(() => LocationCubit());

  /// ------------ Features ------------
  // --- Auth ---
  registerAuthDependencies(getIt);

  // --- Personalization ---
  registerPersonalizationDependencies(getIt);

  /// --- User Events ---
  registerUserEventsDependencies(getIt);

  /// --- Event ---
  registerEventDependencies(getIt);

  getIt.registerLazySingleton<SearchCubit>(() => SearchCubit(getIt()));
}
