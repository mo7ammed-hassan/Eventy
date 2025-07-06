import 'package:eventy/config/service_locator.dart';
import 'package:eventy/features/location/data/repository/location_repository_impl.dart';
import 'package:eventy/features/location/domain/location_repository.dart';
import 'package:eventy/features/location/presentation/cubits/location_cubit.dart';

void registerLocationInjection() {
  getIt.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(getIt(), getIt()),
  );

  getIt.registerFactory<LocationCubit>(() => LocationCubit(getIt()));
}
