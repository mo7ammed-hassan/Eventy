import 'package:eventy/core/utils/dialogs/loading_dialogs.dart';
import 'package:eventy/core/utils/helpers/app_context.dart';
import 'package:eventy/core/utils/helpers/image_picker_helper.dart';
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

  // Location
  LocationEntity? location;
  UploadImages uploadImages = const UploadImages();

  // Controllers
  TextEditingController eventNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

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
        city: address.subAdministrativeArea ?? '',
        street: address.street ?? '',
        country: address.country ?? '',
        latitude: latLng.latitude,
        longitude: latLng.longitude,
      );

      updateLocation(newLocation);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// --- Image Handling ---
  Future<void> pickImage({required bool isThumbnail}) async {
    LoadingDialogs.showLoadingDialog(AppContext.context);
    final image = await ImagePickerHelper.pickImageFromGallery();
    if (image != null) {
      if (isThumbnail) {
        uploadImages = uploadImages.copyWith(thumbnail: image);
      } else {
        uploadImages = uploadImages.copyWith(coverImage: image);
      }
      emit(
        UploadImages(
          thumbnail: uploadImages.thumbnail,
          coverImage: uploadImages.coverImage,
        ),
      );
    }
    if (!AppContext.context.mounted) return;
    LoadingDialogs.hideLoadingDialog(AppContext.context);
  }

  void removeImage({required bool isThumbnail}) {
    uploadImages = UploadImages(
      thumbnail: isThumbnail ? null : uploadImages.thumbnail,
      coverImage: isThumbnail ? uploadImages.coverImage : null,
    );

    emit(
      UploadImages(
        thumbnail: uploadImages.thumbnail,
        coverImage: uploadImages.coverImage,
      ),
    );
  }

  @override
  Future<void> close() {
    eventNameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    return super.close();
  }
}
