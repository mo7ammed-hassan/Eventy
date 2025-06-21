import 'package:equatable/equatable.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';

sealed class BaseEventsState extends Equatable {}

class BaseEventInitial extends BaseEventsState {
  @override
  List<Object?> get props => [];
}

class BaseEventError extends BaseEventsState {
  final String message;

  BaseEventError(this.message);

  @override
  List<Object?> get props => [message];
}

class BaseEventLoading extends BaseEventsState {
  @override
  List<Object?> get props => [];
}

class BaseEventLoaded extends BaseEventsState {
  final List<EventEntity> events;
  final bool isLoadingMore;
  final bool hasMore;

  BaseEventLoaded(this.events, this.isLoadingMore, this.hasMore);

  @override
  List<Object?> get props => [events];
}
