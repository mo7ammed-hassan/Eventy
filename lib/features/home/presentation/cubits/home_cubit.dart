import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/storage/app_storage.dart';
import 'package:eventy/features/home/presentation/cubits/home_state.dart';
import 'package:eventy/features/location/presentation/cubits/location_cubit.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  final _storage = getIt<AppStorage>();

  final LocationCubit locationCubit = getIt<LocationCubit>();

  void init() async {
    // _storage.remove('location');
    // _storage.remove('location_permission_denied');

    final location = locationCubit.getLocation();
    final denied = _storage.getBool('location_permission_denied');

    if (!isClosed) emit(state.copyWith(isLoading: true));

    if (location != null && !denied) {
      if (!isClosed) {
        emit(state.copyWith(shouldRequestLocation: false, isLoading: false));
      }
      await fetchDependOnLocation(location);
    } else if (denied == true) {
      if (!isClosed) {
        emit(state.copyWith(shouldRequestLocation: false, isLoading: false));
      }
      await fetchEvents();
    } else if (location == null && denied == false) {
      if (!isClosed) emit(state.copyWith(shouldRequestLocation: true));
    }
  }

  Future<void> fetchDependOnLocation(LocationEntity? location) async {
    if (!isClosed) {
      emit(state.copyWith(isLoading: true, shouldRequestLocation: false));
    }

    // 1. Call your APIs or do the logic
    await Future.delayed(Duration(seconds: 4));

    // 2. Then stop loading
    if (!isClosed) emit(state.copyWith(isLoading: false, fetchSuccess: true));
  }

  Future<void> fetchEvents() async {
    if (!isClosed) {
      emit(state.copyWith(isLoading: true, shouldRequestLocation: false));
    }

    // 1. Call your APIs or do the logic
    await Future.delayed(Duration(seconds: 4));

    // 2. Then stop loading
    if (!isClosed) {
      emit(
        state.copyWith(
          isLoading: false,
          fetchSuccess: true,
          shouldRequestLocation: false,
        ),
      );
    }
  }
}
