import 'package:equatable/equatable.dart';
import 'package:eventy/core/enums/enums.dart';

sealed class CreateEventState extends Equatable {
  const CreateEventState();
  @override
  List<Object?> get props => [];
}

class CreateEventInitial extends CreateEventState {}

class CreateEventLoading extends CreateEventState {
  const CreateEventLoading();
}

class CreateEventSuccess extends CreateEventState {
  final String message;
  const CreateEventSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateEventFailure extends CreateEventState {
  final String message;
  const CreateEventFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateField<T> extends CreateEventState {
  final T field;
  const UpdateField(this.field);

  @override
  List<Object?> get props => [field];
}

class UploadImages extends CreateEventState {
  final String? thumbnail;
  final String? coverImage;

  const UploadImages({this.thumbnail, this.coverImage});

  UploadImages copyWith({String? thumbnail, String? coverImage}) {
    return UploadImages(
      thumbnail: thumbnail ?? this.thumbnail,
      coverImage: coverImage ?? this.coverImage,
    );
  }

  @override
  List<Object?> get props => [thumbnail, coverImage];
}

class ValidationFieldFailure extends CreateEventState {
  final String message;
  final DateTime timestamp;

  ValidationFieldFailure(this.message) : timestamp = DateTime.now();

  @override
  List<Object?> get props => [message, timestamp];
}

class ToggleEventType extends CreateEventState {
  final EventType eventType;
  const ToggleEventType(this.eventType);

  @override
  List<Object?> get props => [eventType];
}
