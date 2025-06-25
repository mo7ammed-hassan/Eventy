import 'package:equatable/equatable.dart';

sealed class CreateEventState extends Equatable {
  const CreateEventState();
  @override
  List<Object?> get props => [];
}

class CreateEventInitial extends CreateEventState {}

class CreateEventLoading extends CreateEventState {}

class CreateEventError extends CreateEventState {
  final String message;
  const CreateEventError(this.message);
}

class CreateEventSuccess extends CreateEventState {
  final String message;
  const CreateEventSuccess(this.message);
}
