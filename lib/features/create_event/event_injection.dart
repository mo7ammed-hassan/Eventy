import 'package:eventy/core/network/api_client.dart';
import 'package:eventy/features/create_event/data/datasources/event_remote_data_source.dart';
import 'package:eventy/features/create_event/data/repositories/event_repository_impl.dart';
import 'package:eventy/features/create_event/domain/repositories/event_repository.dart';
import 'package:eventy/features/create_event/domain/usecases/get_all_events_usecase.dart';

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

  getIt.registerLazySingleton<GetAllEventsUsecase>(
    () => GetAllEventsUsecase(getIt<EventRepository>()),
  );
}
