import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/storage/secure_storage.dart';
import 'package:eventy/core/utils/dialogs/custom_dialogs.dart';
import 'package:eventy/features/auth/domain/repositories/auth_repo.dart';
import 'package:eventy/features/personalization/data/mappers/user_mappers.dart';
import 'package:eventy/features/personalization/domain/entities/user_entity.dart';
import 'package:eventy/features/user_events/user_events_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventy/core/api/api_error.dart';
import 'package:eventy/core/api/retry_manger.dart';
import 'package:eventy/features/personalization/domain/repositories/profile_repo.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._profileRepo, this._authRepo) : super(UserState());

  final ProfileRepo _profileRepo;
  final AuthRepo _authRepo;
  final SecureStorage _storage = getIt<SecureStorage>();

  UserEntity user = UserEntity.empty();
  String profileLink = '';

  Future<void> getUserProfile() async {
    final accessToken = await _storage.getAccessToken();

    if (accessToken == null) return;

    emit(state.copyWith(isLoading: true));

    final result = await _profileRepo.getUserProfile();

    result.fold(
      (error) {
        if (error.message == "No internet connection" ||
            error is NetworkError) {
          RetryManger.addToQueue(getUserProfile);
        }

        emit(state.copyWith(errorMessage: error.message));
      },
      (fetchedUser) {
        user = fetchedUser;
        emit(state.copyWith(user: user, isLoading: false));
      },
    );
  }

  Future<String> shareProfileLink() async {
    emit(state.copyWith(isLoading: true));

    final result = await _profileRepo.shareProfileLink();
    return result.fold(
      (error) {
        emit(state.copyWith(errorMessage: error.message));
        return error.message;
      },
      (link) {
        profileLink = link;
        emit(state.copyWith(shareLink: profileLink, isLoading: false));
        return link;
      },
    );
  }

  Future<void> logoutConfirm() async {
    final confirmResult = await CustomDialogs.showConfirmationDialog();

    if (confirmResult == true) {
      await logout();
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(isLoggingOut: true));

    final result = await _authRepo.logout();
    result.fold((error) => emit(state.copyWith(errorMessage: error.message)), (
      _,
    ) {
      unRegisterUserEventsCubits(getIt);
      emit(UserState());
    });
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    final currentUser = state.user;
    if (currentUser == null || data.isEmpty) return;

    final updatedUser = currentUser.copyWith(
      name: data['name'],
      phone: data['phone'],
      address: data['address'],
      location: data['location'],
    );

    if (updatedUser.isEqual(currentUser)) return;

    emit(state.copyWith(isUpdating: true));

    final result = await _profileRepo.updateUserProfile(
      data: updatedUser.toModel().toJson(),
    );

    result.fold(
      (error) => emit(
        state.copyWith(
          errorMessage: error.message,
          isUpdating: false,
          isUpdatingImage: false,
        ),
      ),
      (_) => emit(
        state.copyWith(
          isUpdating: false,
          user: updatedUser,
          successMessage: 'Profile updated successfully',
        ),
      ),
    );
  }

  Future<void> updateProfileImage(String imagePath) async {
    if (imagePath.isEmpty) return;

    emit(state.copyWith(isUpdatingImage: true));

    final result = await _profileRepo.updateUserProfile(
      data: {'image': imagePath},
    );

    result.fold(
      (error) => emit(
        state.copyWith(
          isUpdatingImage: false,
          updateImageSuccess: false,
          errorMessage: error.message,
        ),
      ),
      (updatedUser) => emit(
        state.copyWith(
          isUpdatingImage: false,
          updateImageSuccess: true,
          user: state.user?.copyWith(imageUrl: imagePath),
        ),
      ),
    );
  }

  void transientAllMessage() {
    emit(
      state.copyWith(
        errorMessage: null,
        successMessage: null,
        isUpdating: false,
        isUpdatingImage: false,
        updateImageSuccess: false,
      ),
    );
  }

  // Future.wait
  Future<void> getUserData() async {
    await Future.wait([getUserProfile(), shareProfileLink()]);
  }
}
