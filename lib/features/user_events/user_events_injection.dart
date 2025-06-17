import 'package:eventy/core/api/api_client.dart';
import 'package:eventy/features/user_events/data/datasources/user_events_remote_datasource.dart';
import 'package:eventy/features/user_events/data/repositories/user_events_repository_impl.dart';
import 'package:eventy/features/user_events/domain/repositories/user_events_repository.dart';
import 'package:eventy/features/user_events/domain/usecases/get_created_events_usecase.dart';
import 'package:eventy/features/user_events/domain/usecases/get_favorite_events_usecase.dart';
import 'package:eventy/features/user_events/domain/usecases/get_pending_events_usecase.dart';
import 'package:eventy/features/user_events/presentation/cubits/created_events_cubit.dart';
import 'package:eventy/features/user_events/presentation/cubits/favorite_events_cubit.dart';
import 'package:eventy/features/user_events/presentation/cubits/pending_events_cubit.dart';
import 'package:get_it/get_it.dart';

void registerUserEventsDependencies(GetIt getIt) {
  /// --- Data source
  getIt.registerLazySingleton<UserEventsRemoteDataSource>(
    () => UserEventsRemoteDataSourceImpl(getIt<ApiClient>()),
  );

  /// --- Repository
  getIt.registerLazySingleton<UserEventsRepository>(
    () => UserEventsRepositoryImpl(getIt<UserEventsRemoteDataSource>()),
  );

  /// --- Use Cases
  getIt.registerLazySingleton<GetCreatedEventsUsecase>(
    () => GetCreatedEventsUsecase(getIt()),
  );
  getIt.registerLazySingleton<GetFavoriteEventsUsecase>(
    () => GetFavoriteEventsUsecase(getIt()),
  );
  getIt.registerLazySingleton<GetPendingEventsUsecase>(
    () => GetPendingEventsUsecase(getIt()),
  );

  /// --- Cubits
  getIt.registerLazySingleton<CreatedEventsCubit>(
    () => CreatedEventsCubit(getCreatedEventsUsecase: getIt()),
  );
  getIt.registerLazySingleton<FavoriteEventsCubit>(
    () => FavoriteEventsCubit(getFavoriteEventsUsecase: getIt()),
  );
  getIt.registerLazySingleton<PendingEventsCubit>(
    () => PendingEventsCubit(getPendingEventsUsecase: getIt()),
  );
}

void unRegisterUserEventsCubits(GetIt getIt) {
  getIt.unregisterAll();
}

void registerUserEventsCubits(GetIt getIt) {
  if (!getIt.isRegistered<CreatedEventsCubit>()) {
    getIt.registerLazySingleton<CreatedEventsCubit>(
      () => CreatedEventsCubit(getCreatedEventsUsecase: getIt()),
    );
  }

  if (!getIt.isRegistered<FavoriteEventsCubit>()) {
    getIt.registerLazySingleton<FavoriteEventsCubit>(
      () => FavoriteEventsCubit(getFavoriteEventsUsecase: getIt()),
    );
  }

  if (!getIt.isRegistered<PendingEventsCubit>()) {
    getIt.registerLazySingleton<PendingEventsCubit>(
      () => PendingEventsCubit(getPendingEventsUsecase: getIt()),
    );
  }
}

extension on GetIt {
  void unregisterAll() {
    unregister<CreatedEventsCubit>();
    unregister<FavoriteEventsCubit>();
    unregister<PendingEventsCubit>();
  }
}
