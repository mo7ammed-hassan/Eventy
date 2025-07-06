import 'package:eventy/features/create_event/domain/repositories/event_repository.dart';
import 'package:eventy/features/create_event/domain/usecases/get_nearby_events_usecase.dart';
import 'package:eventy/features/home/presentation/cubits/home_cubit.dart';
import 'package:get_it/get_it.dart';

void registerHomeDependencies(GetIt getIt) {
  getIt.registerLazySingleton<GetNearbyEventsUseCase>(
    () => GetNearbyEventsUseCase(getIt<EventRepository>()),
  );
  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit(getIt(),getIt()));
}
