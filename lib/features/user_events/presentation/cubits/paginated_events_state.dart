import 'package:equatable/equatable.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';

sealed class PaginatedEventsState extends Equatable {}

class BaseEventInitial extends PaginatedEventsState {
  @override
  List<Object?> get props => [];
}

class BaseEventError extends PaginatedEventsState {
  final String message;

  BaseEventError(this.message);

  @override
  List<Object?> get props => [message];
}

class BaseEventLoading extends PaginatedEventsState {
  @override
  List<Object?> get props => [];
}

class BaseEventLoaded extends PaginatedEventsState {
  final List<EventEntity> events;
  final bool isLoadingMore;
  final bool hasMore;

  BaseEventLoaded(this.events, this.isLoadingMore, this.hasMore);

  @override
  List<Object?> get props => [events];
}
