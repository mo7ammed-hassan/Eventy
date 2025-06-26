import 'package:eventy/core/network/api_client.dart';
import 'package:eventy/features/create_event/data/datasources/event_remote_data_source.dart';
import 'package:eventy/features/create_event/data/repositories/event_repository_impl.dart';
import 'package:eventy/features/create_event/domain/repositories/event_repository.dart';
import 'package:eventy/features/create_event/domain/usecases/create_event_usecase.dart';
import 'package:eventy/features/create_event/domain/usecases/delete_event_use_case.dart';
import 'package:eventy/features/create_event/domain/usecases/update_event_use_case.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';
import 'package:get_it/get_it.dart';

void registerEventDependencies(GetIt getIt) {
  /// --- Data source
  getIt.registerLazySingleton<EventRemoteDataSource>(
    () => EventRemoteDataSourceImpl(getIt<ApiClient>()),
  );

  /// --- Repository
  getIt.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(getIt<EventRemoteDataSource>()),
  );

  /// --- Use Cases
  getIt.registerLazySingleton<CreateEventUsecase>(
    () => CreateEventUsecase(getIt()),
  );
  getIt.registerLazySingleton<UpdateEventUseCase>(
    () => UpdateEventUseCase(getIt()),
  );
  getIt.registerLazySingleton<DeleteEventUseCase>(
    () => DeleteEventUseCase(getIt()),
  );

  /// --- Cubits
  getIt.registerFactory<CreateEventCubit>(
    () => CreateEventCubit(getIt<CreateEventUsecase>()),
  );
}
