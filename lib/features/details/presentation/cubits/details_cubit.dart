import 'package:eventy/config/service_locator.dart';
import 'package:eventy/features/details/presentation/cubits/details_state.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/usecases/join_event_usecase.dart';
import 'package:eventy/features/user_events/presentation/cubits/joined_events_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this.joinEventUsecase) : super(DetailsStateInitial());

  final JoinEventUsecase joinEventUsecase;

  Future<void> joinEvent({required EventEntity event}) async {
    emit(JoinEventLoading());

    final result = await joinEventUsecase.call(eventId: event.id);
    result.fold((error) => emit(JoinEventFailure(error.message)), (_) {
      getIt<JoinedEventsCubit>().addJoinedEvent(event);
      emit(JoinEventSuccess('Successfully joined the event'));
    });
  }
}
