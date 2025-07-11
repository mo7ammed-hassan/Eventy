import 'package:eventy/core/abstract_service/event_enricher_service.dart';
import 'package:eventy/core/storage/app_storage.dart';
import 'package:eventy/features/create_event/event_injection.dart';
import 'package:eventy/features/details/details_injection.dart';
import 'package:eventy/features/home/home_injection.dart';
import 'package:eventy/features/location/location_injection.dart';
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
  
  /// ------------ Locations ------------
  registerLocationInjection();

  /// ------------ Features ------------
  // --- Auth ---
  registerAuthDependencies(getIt);

  // --- Personalization ---
  registerPersonalizationDependencies(getIt);

  /// --- User Enricher ---
  getIt.registerFactory<EventEnricherService>(
    () => EventEnricherServiceImpl(getIt()),
  );

  /// --- User Events ---
  registerUserEventsDependencies(getIt);

  /// --- Event ---
  registerEventDependencies(getIt);

  /// --- Home ---
  registerHomeDependencies(getIt);

  /// --- Details ---
  registerDetailsInjection(getIt);

  getIt.registerLazySingleton<SearchCubit>(() => SearchCubit(getIt()));
}
