import 'package:eventy/features/create_event/domain/entities/create_event_entity.dart';
import 'package:eventy/features/create_event/domain/usecases/create_event_usecase.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit(this._createEventUsecase) : super(CreateEventInitial());

  final CreateEventUsecase _createEventUsecase;

  // Controllers
  TextEditingController eventNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  Future<void> createEvent() async {
    emit(CreateEventLoading());

    final CreateEventEntity event = CreateEventEntity.empty();

    final result = await _createEventUsecase.call(event: event);

    result.fold((failure) => emit(CreateEventFailure(failure.message)), (_) {
      emit(CreateEventSuccess('Event created successfully'));
    });
  }
}
