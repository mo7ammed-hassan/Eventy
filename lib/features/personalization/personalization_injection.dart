import 'package:eventy/core/network/api_client.dart';
import 'package:eventy/core/storage/secure_storage.dart';
import 'package:eventy/features/auth/domain/repositories/auth_repo.dart';
import 'package:eventy/features/personalization/data/datasources/profile_remote_data_souces.dart';
import 'package:eventy/features/personalization/data/repositories/profile_repo_impl.dart';
import 'package:eventy/features/personalization/domain/repositories/profile_repo.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_cubit.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_event/user_event_cubit.dart';
import 'package:get_it/get_it.dart';

void registerPersonalizationDependencies(GetIt getIt) {
  // -- Data Source
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(getIt<ApiClient>()),
  );
  // -- Repo
  getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(
      getIt<ProfileRemoteDataSource>(),
      getIt<SecureStorage>(),
    ),
  );

  /// -- Cubit
  getIt.registerLazySingleton<UserCubit>(
    () => UserCubit(getIt<ProfileRepo>(), getIt<AuthRepo>()),
  );
  getIt.registerFactory<UserEventCubit>(
    () => UserEventCubit(getIt<ProfileRepo>()),
  );
}

 

