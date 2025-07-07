import 'package:eventy/core/enums/enums.dart';
import 'package:eventy/core/utils/dialogs/loading_dialogs.dart';
import 'package:eventy/core/utils/helpers/app_context.dart';
import 'package:eventy/core/utils/helpers/image_picker_helper.dart';
import 'package:eventy/features/create_event/domain/entities/create_event_entity.dart';
import 'package:eventy/features/personalization/domain/entities/user_entity.dart';
import 'package:eventy/features/user_events/domain/usecases/create_event_usecase.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_state.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_cubit.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit(this._createEventUsecase) : super(CreateEventInitial());

  final CreateEventUsecase _createEventUsecase;


  UserEntity? userEntity;

  late UserEntity? user;

  void init({required UserCubit userCubit}) async {
    userEntity = userCubit.user;
    if (userEntity != null) {
      user = userEntity!;
    } else {
      await userCubit.getUserProfile();
      user = userCubit.user;
    }
  }

  // -- Controllers
  TextEditingController eventNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController? categoryController = TextEditingController();
  TextEditingController? priceController = TextEditingController();

  // -- Attributes
  String? selectedCategory;
  LocationEntity? location;
  UploadImages uploadImages = const UploadImages();
  DateTime? dateRange;
  String? time;
  bool isPaid = false;

  EventType eventType = EventType.public;

  Future<void> createEvent() async {
    if (!validateAllFields()) return;

    emit(CreateEventLoading());

    final createdEvent = CreateEventEntity(
      name: eventNameController.text,
      description: descriptionController.text,
      category: categoryController!.text.trim().isEmpty
          ? selectedCategory
          : categoryController?.text.trim(),
      price: isPaid
          ? (priceController?.text.trim().isEmpty ?? true
                ? '0.0'
                : priceController!.text.trim())
          : '0.0',
      isPaid: isPaid,
      image: uploadImages.thumbnail,
      coverImage: uploadImages.coverImage,
      location: location,
      date: dateRange,
      time: time,
      type: eventType.capitalizedName.toString(),
      isRecurring: 'Not Annual',
      host: user?.id,
      attendees: [],
    );

    final result = await _createEventUsecase.call(event: createdEvent);

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
      final fullAddress =
          '${address.subAdministrativeArea}, ${address.country}';

      final newLocation = LocationEntity(
        address: fullAddress,
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

  void setDateRange({required DateTime start, required DateTime end}) {
    dateRange = start;
  }

  void setTime(String time) {
    this.time = time;
  }

  void changeEventType(EventType eventType) {
    if (this.eventType == eventType) return;
    this.eventType = eventType;
    _updateField<EventType>(eventType);
  }

  void setPaid(bool value) {
    isPaid = value;
    _updateField<bool>(value);
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

  /// -- Validators -- ///
  bool detailsValidator() {
    final name = eventNameController.text.trim();
    final description = descriptionController.text.trim();
    final price = priceController?.text.trim() ?? '0.0';
    final isDateSelected = dateRange != null;
    final isTimeSelected = time != null;

    if (name.isEmpty && description.isEmpty && price.isEmpty) {
      emit(
        ValidationFieldFailure('Please fill all required fields in the form.'),
      );
      return false;
    }

    if (name.isEmpty || name.length < 3) {
      emit(
        ValidationFieldFailure(
          'Please enter an event name with at least 5 characters.',
        ),
      );
      return false;
    }

    if (description.isEmpty) {
      emit(ValidationFieldFailure('Please enter an event description.'));
      return false;
    }

    if ((price.isEmpty || double.tryParse(price) == null) && isPaid) {
      emit(ValidationFieldFailure('Please enter a valid price.'));
      return false;
    }

    if (!isDateSelected && !isTimeSelected) {
      emit(ValidationFieldFailure('Please select both date and time.'));
      return false;
    }

    if (!isDateSelected) {
      emit(ValidationFieldFailure('Please select a date.'));
      return false;
    }

    if (!isTimeSelected) {
      emit(ValidationFieldFailure('Please select a time.'));
      return false;
    }

    return true;
  }

  bool categoriesValidator() {
    final isValid =
        selectedCategory != null ||
        (categoryController?.text.trim().isNotEmpty ?? false);

    if (!isValid) {
      emit(ValidationFieldFailure('Please select or enter a category.'));
    }

    return isValid;
  }

  bool locationValidator() {
    final isValid = location != null;

    if (!isValid) {
      emit(ValidationFieldFailure('Please select a location on the map.'));
    }

    return isValid;
  }

  bool imagesValidator() {
    final isThumbnailValid = uploadImages.thumbnail != null;
    final isCoverValid = uploadImages.coverImage != null;

    if (!isThumbnailValid && !isCoverValid) {
      emit(
        ValidationFieldFailure(
          'Please upload both a thumbnail and a cover image.',
        ),
      );
      return false;
    }

    if (!isThumbnailValid) {
      emit(ValidationFieldFailure('Please upload a thumbnail image.'));
      return false;
    }

    if (!isCoverValid) {
      emit(ValidationFieldFailure('Please upload a cover image.'));
      return false;
    }

    return true;
  }

  bool validateAllFields() {
    final isDetailsValid = detailsValidator();
    final isCategoryValid = categoriesValidator();
    final isLocationValid = locationValidator();
    final isImagesValid = imagesValidator();

    return isDetailsValid &&
        isCategoryValid &&
        isLocationValid &&
        isImagesValid;
  }

  @override
  Future<void> close() {
    eventNameController.dispose();
    descriptionController.dispose();
    categoryController?.dispose();
    return super.close();
  }
}
