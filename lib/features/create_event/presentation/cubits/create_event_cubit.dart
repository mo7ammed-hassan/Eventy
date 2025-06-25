import 'package:eventy/features/create_event/presentation/cubits/create_event_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit() : super(CreateEventInitial());
}
