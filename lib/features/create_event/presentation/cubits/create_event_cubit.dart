import 'package:eventy/features/create_event/domain/usecases/create_event_usecase.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit(this._createEventUsecase) : super(CreateEventInitial());

  final CreateEventUsecase _createEventUsecase;

  Future<void> createEvent() async {
    emit(CreateEventLoading());

    // final result = await _createEventUsecase.call(event: event);

    // result.fold((failure) => emit(CreateEventFailure(failure.message)), (_) {
    //   emit(CreateEventSuccess('Event created successfully'));
    // });
  }
}
