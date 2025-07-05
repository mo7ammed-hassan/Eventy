import 'package:eventy/features/details/presentation/cubits/details_cubit.dart';
import 'package:get_it/get_it.dart';

void registerDetailsInjection(GetIt getIt) {
  getIt.registerFactory<DetailsCubit>(() => DetailsCubit(getIt()));
}
