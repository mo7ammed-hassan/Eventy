import 'package:equatable/equatable.dart';

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
}

class UpdateField<T> extends CreateEventState {
  final T field;
  const UpdateField(this.field);

  @override
  List<Object?> get props => [field];
}
