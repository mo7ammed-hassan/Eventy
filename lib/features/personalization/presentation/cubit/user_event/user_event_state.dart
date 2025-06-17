import 'package:equatable/equatable.dart';
import 'package:eventy/features/user_events/data/models/event_model.dart';

abstract class UserEventState extends Equatable {
  const UserEventState();
}

class UserEventInitial extends UserEventState {
  @override
  List<Object> get props => [];
}

// customized events state
class UserEventLoading extends UserEventState {
  @override
  List<Object> get props => [];
}

class UserEventLoaded extends UserEventState {
  final List<EventModel> events;

  const UserEventLoaded(this.events);

  @override
  List<Object> get props => [events];
}

class UserEventError extends UserEventState {
  final String message;

  const UserEventError(this.message);

  @override
  List<Object> get props => [];
}

// favourite events state
class FavouriteEventLoading extends UserEventState {
  @override
  List<Object> get props => [];
}

class FavouriteEventLoaded extends UserEventState {
  final List<EventModel> events;

  const FavouriteEventLoaded(this.events);

  @override
  List<Object> get props => [events];
}

class FavouriteEventError extends UserEventState {
  final String message;

  const FavouriteEventError(this.message);

  @override
  List<Object> get props => [];
}
