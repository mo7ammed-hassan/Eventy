import 'package:eventy/features/create_event/domain/entities/create_event_entity.dart';
import 'package:eventy/features/create_event/domain/usecases/create_event_usecase.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_state.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit(this._createEventUsecase) : super(CreateEventInitial());

  final CreateEventUsecase _createEventUsecase;

  LocationEntity? location;

  // Controllers
  TextEditingController eventNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  String image = '', coverImage = '';

  Future<void> createEvent() async {
    emit(CreateEventLoading());

    final CreateEventEntity event = CreateEventEntity.empty();

    final result = await _createEventUsecase.call(event: event);

    result.fold((failure) => emit(CreateEventFailure(failure.message)), (_) {
      emit(CreateEventSuccess('Event created successfully'));
    });
  }

  /// -- Update field --
  void _updateField<T>(T value) => emit(UpdateField<T>(value));

  /// ---- Location ---- ///

  /// -- Update user location
  void updateLocation(LocationEntity location) {
    if (this.location == location) return;

    this.location = location;
    _updateField<LocationEntity>(location);
  }

  /// -- Change user location When user change location from Map
  Future<void> changeLocationFromMap(LatLng latLng) async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      final address = placemarks.first;
      final newLocation = LocationEntity(
        address: address.country ?? '',
        latitude: latLng.latitude,
        longitude: latLng.longitude,
      );

      updateLocation(newLocation);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> close() {
    eventNameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    return super.close();
  }
}
