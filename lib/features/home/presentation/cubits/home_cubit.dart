import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/storage/app_storage.dart';
import 'package:eventy/features/home/presentation/cubits/home_state.dart';
import 'package:eventy/features/location/data/location_model.dart';
import 'package:eventy/features/user_events/data/mapper/location_mapper.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  final _storage = getIt<AppStorage>();

  void init() async {
    final location = getLocation();
    final denied = _storage.getBool('location_permission_denied');

    if (location != null && !denied) {
      emit(state.copyWith(shouldRequestLocation: false));
      await fetchDependOnLocation(location);
    } else if (denied == true) {
      emit(state.copyWith(shouldRequestLocation: false));
      await fetchEvents();
    } else if (location == null && denied == false) {
      emit(state.copyWith(shouldRequestLocation: true));
    }
  }

  Future<void> fetchDependOnLocation(LocationEntity? location) async {
    emit(state.copyWith(isLoading: true, shouldRequestLocation: false));

    // 1. Call your APIs or do the logic
    await Future.delayed(Duration(seconds: 4));

    // 2. Then stop loading
    emit(state.copyWith(isLoading: false, fetchSuccess: true));
  }

  Future<void> fetchEvents() async {
    emit(state.copyWith(isLoading: true, shouldRequestLocation: false));

    // 1. Call your APIs or do the logic
    await Future.delayed(Duration(seconds: 4));

    // 2. Then stop loading
    emit(
      state.copyWith(
        isLoading: false,
        fetchSuccess: true,
        shouldRequestLocation: false,
      ),
    );
  }

  LocationEntity? getLocation() {
    final Map<String, dynamic>? json = _storage.getJson('location');
    if (json == null) return null;
    return (LocationModel.fromJson(json)).toEntity();
  }
}
