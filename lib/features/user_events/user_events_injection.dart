import 'package:eventy/core/network/api_client.dart';
import 'package:eventy/core/storage/secure_storage.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';
import 'package:eventy/features/sceduale/presentation/cubits/schedule_cubit.dart';
import 'package:eventy/features/user_events/data/datasources/manage_user_events_remote_datasource.dart';
import 'package:eventy/features/user_events/data/datasources/user_events_remote_data_source.dart';
import 'package:eventy/features/user_events/data/repositories/manage_user_event_repository_impl.dart';
import 'package:eventy/features/user_events/data/repositories/user_events_repository_impl.dart';
import 'package:eventy/features/user_events/domain/repositories/manage_user_events_repository.dart';
import 'package:eventy/features/user_events/domain/repositories/user_events_repository.dart';
import 'package:eventy/features/user_events/domain/usecases/add_event_to_favorite_usecase.dart';
import 'package:eventy/features/user_events/domain/usecases/create_event_usecase.dart';
import 'package:eventy/features/user_events/domain/usecases/delete_event_usecase.dart';
import 'package:eventy/features/user_events/domain/usecases/favorite_event_usecases.dart';
import 'package:eventy/features/user_events/domain/usecases/get_created_events_usecase.dart';
import 'package:eventy/features/user_events/domain/usecases/get_favorite_events_usecase.dart';
import 'package:eventy/features/user_events/domain/usecases/get_pending_events_usecase.dart';
import 'package:eventy/features/user_events/domain/usecases/get_user_joined_events_usecase.dart';
import 'package:eventy/features/user_events/domain/usecases/join_event_usecase.dart';
import 'package:eventy/features/user_events/domain/usecases/remove_event_from_favorite_usecase.dart';
import 'package:eventy/features/user_events/domain/usecases/update_event_usecase.dart';
import 'package:eventy/features/user_events/presentation/cubits/joined_events_cubit.dart';
import 'package:eventy/features/user_events/presentation/cubits/favorite_events_cubit.dart';
import 'package:eventy/features/user_events/presentation/cubits/pending_events_cubit.dart';
import 'package:get_it/get_it.dart';

void registerUserEventsDependencies(GetIt getIt) {
  /// --- Data source
  getIt.registerLazySingleton<UserEventsRemoteDataSource>(
    () => UserEventsRemoteDataSourceImpl(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<ManageUserEventsRemoteDataSource>(
    () => ManageUserEventsRemoteDataSourceImpl(getIt<ApiClient>()),
  );

  /// --- Repository
  getIt.registerLazySingleton<UserEventsRepository>(
    () => UserEventsRepositoryImpl(
      getIt<UserEventsRemoteDataSource>(),
      getIt<SecureStorage>(),
    ),
  );
  getIt.registerLazySingleton<ManageUserEventsRepository>(
    () => ManageUserEventRepositoryImpl(
      getIt<ManageUserEventsRemoteDataSource>(),
    ),
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
  getIt.registerLazySingleton<GetUserJoinedEventsUsecase>(
    () => GetUserJoinedEventsUsecase(getIt()),
  );
  getIt.registerLazySingleton<AddEventToFavoriteUsecase>(
    () => AddEventToFavoriteUsecase(getIt()),
  );
  getIt.registerLazySingleton<RemoveEventFromFavoriteUsecase>(
    () => RemoveEventFromFavoriteUsecase(getIt()),
  );
  getIt.registerLazySingleton<CreateEventUsecase>(
    () => CreateEventUsecase(getIt()),
  );
  getIt.registerLazySingleton<UpdateEventUseCase>(
    () => UpdateEventUseCase(getIt()),
  );
  getIt.registerLazySingleton<DeleteEventUseCase>(
    () => DeleteEventUseCase(getIt()),
  );
  getIt.registerLazySingleton<FavoriteEventUseCases>(
    () => FavoriteEventUseCases(
      get: getIt<GetFavoriteEventsUsecase>(),
      add: getIt<AddEventToFavoriteUsecase>(),
      remove: getIt<RemoveEventFromFavoriteUsecase>(),
    ),
  );
  getIt.registerLazySingleton<JoinEventUsecase>(
    () => JoinEventUsecase(getIt()),
  );

  /// --- Cubits
  getIt.registerLazySingleton<JoinedEventsCubit>(
    () => JoinedEventsCubit(getCreatedEventsUsecase: getIt()),
  );
  getIt.registerLazySingleton<FavoriteEventsCubit>(
    () => FavoriteEventsCubit(getIt<FavoriteEventUseCases>()),
  );
  getIt.registerLazySingleton<PendingEventsCubit>(
    () => PendingEventsCubit(getPendingEventsUsecase: getIt()),
  );
  getIt.registerFactory<ScheduleCubit>(
    () => ScheduleCubit(getUserJoinedEventsUsecase: getIt()),
  );
  getIt.registerFactory<CreateEventCubit>(
    () => CreateEventCubit(getIt<CreateEventUsecase>()),
  );
}

void unRegisterUserEventsCubits(GetIt getIt) {
  getIt.unregisterAll();
}

void registerUserEventsCubits(GetIt getIt) {
  if (!getIt.isRegistered<JoinedEventsCubit>()) {
    getIt.registerLazySingleton<JoinedEventsCubit>(
      () => JoinedEventsCubit(getCreatedEventsUsecase: getIt()),
    );
  }

  if (!getIt.isRegistered<FavoriteEventsCubit>()) {
    getIt.registerLazySingleton<FavoriteEventsCubit>(
      () => FavoriteEventsCubit(getIt()),
    );
  }

  if (!getIt.isRegistered<PendingEventsCubit>()) {
    getIt.registerLazySingleton<PendingEventsCubit>(
      () => PendingEventsCubit(getPendingEventsUsecase: getIt()),
    );
  }

  if (!getIt.isRegistered<ScheduleCubit>()) {
    getIt.registerLazySingleton<ScheduleCubit>(
      () => ScheduleCubit(getUserJoinedEventsUsecase: getIt()),
    );
  }
}

extension on GetIt {
  void unregisterAll() {
    unregister<JoinedEventsCubit>();
    unregister<FavoriteEventsCubit>();
    unregister<PendingEventsCubit>();
    unregister<ScheduleCubit>();
  }
}
