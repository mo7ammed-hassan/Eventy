import 'package:eventy/core/api/api_error.dart';
import 'package:eventy/core/api/retry_manger.dart';
import 'package:eventy/core/widgets/popups/loaders.dart';
import 'package:eventy/features/personalization/domain/repositories/profile_repo.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_event/user_event_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserEventCubit extends Cubit<UserEventState> {
  final ProfileRepo _userRepo;

  UserEventCubit(this._userRepo) : super(UserEventInitial());

  Future<void> fetchCustomizedEvents({bool forceRefresh = false}) async {
    // check if cubit not closed
    if (isClosed) return;
    // Return cached data if available and not forcing refresh

    emit(UserEventLoading());

    final result = await _userRepo.getCreatedEvents();

    result.fold(
      (error) {
        if (error.message == "No internet connection" ||
            error is NetworkError) {
          RetryManger.addToQueue(fetchCustomizedEvents);
        }
        emit(const UserEventError("Failed to load events"));
        Loaders.warningSnackBar(title: "Error", message: error.message);
      },
      (events) {
        if (isClosed) return;
        emit(UserEventLoaded(events));
      },
    );
  }

  // Call this when you know data might be stale
  void refreshEvents() {
    fetchCustomizedEvents();
  }
}
