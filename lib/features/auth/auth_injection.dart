import 'package:eventy/core/network/api_client.dart';
import 'package:eventy/core/storage/secure_storage.dart';
import 'package:eventy/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:eventy/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:eventy/features/auth/domain/repositories/auth_repo.dart';
import 'package:eventy/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:eventy/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:get_it/get_it.dart';

void registerAuthDependencies(GetIt getIt) {
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(getIt<AuthRemoteDataSource>(), getIt<SecureStorage>()),
  );

  getIt.registerFactory(() => SignInCubit(authRepo: getIt()));
  getIt.registerFactory(() => SignupCubit(authRepo: getIt()));
}
