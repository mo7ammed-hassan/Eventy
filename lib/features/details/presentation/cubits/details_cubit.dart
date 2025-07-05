import 'package:eventy/features/details/presentation/cubits/details_state.dart';
import 'package:eventy/features/user_events/domain/usecases/join_event_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this.joinEventUsecase) : super(DetailsStateInitial());

  final JoinEventUsecase joinEventUsecase;

  Future<void> joinEvent({required String eventId}) async {
    emit(JoinEventLoading());

    final result = await joinEventUsecase.call(eventId: eventId);
    result.fold(
      (error) => emit(JoinEventFailure(error.message)),
      (_) => emit(JoinEventSuccess('Successfully joined the event')),
    );
  }
}
