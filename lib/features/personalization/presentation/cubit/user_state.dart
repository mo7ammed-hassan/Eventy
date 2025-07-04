import 'package:equatable/equatable.dart';
import 'package:eventy/features/personalization/domain/entities/user_entity.dart';

/// --- Unified State ---
class UserState extends Equatable {
  final UserEntity? user;
  final UserEntity? userById;

  final bool isLoading;
  final bool isUpdating;
  final bool isSharingProfile;
  final bool isLoggingOut;
  final String? shareLink;
  final String? errorMessage;
  final String? successMessage;
  final bool isUpdatingImage;
  final bool updateImageSuccess;

  const UserState({
    this.user,
    this.userById,
    this.isLoading = false,
    this.isUpdating = false,
    this.isUpdatingImage = false,
    this.isSharingProfile = false,
    this.isLoggingOut = false,
    this.shareLink,
    this.errorMessage,
    this.successMessage,
    this.updateImageSuccess = false,
  });

  UserState copyWith({
    UserEntity? user,
    UserEntity? userById,
    bool? isLoading,
    bool? isUpdating,
    bool? isUpdatingImage,
    bool? isSharingProfile,
    bool? isLoggingOut,
    String? shareLink,
    String? errorMessage,
    String? successMessage,
    bool? updateImageSuccess = false,
  }) {
    return UserState(
      user: user ?? this.user,
      userById: userById ?? this.userById,
      isLoading: isLoading ?? this.isLoading,
      isUpdating: isUpdating ?? this.isUpdating,
      isUpdatingImage: isUpdatingImage ?? this.isUpdatingImage,
      isSharingProfile: isSharingProfile ?? this.isSharingProfile,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
      shareLink: shareLink ?? this.shareLink,
      errorMessage: errorMessage,
      successMessage: successMessage,
      updateImageSuccess: updateImageSuccess ?? this.updateImageSuccess,
    );
  }

  factory UserState.initial() => const UserState();

  @override
  List<Object?> get props => [
    user,
    isLoading,
    isUpdating,
    isUpdatingImage,
    isSharingProfile,
    isLoggingOut,
    shareLink,
    errorMessage,
    successMessage,
  ];
}

// import 'package:equatable/equatable.dart';
// import 'package:eventy/features/personalization/domain/entities/user_entity.dart';

// abstract class UserState extends Equatable {
//   const UserState();
//   @override
//   List<Object?> get props => [];
// }

// // === Loading States ===
// class UserInitial extends UserState {}

// class UserLoading extends UserState {}

// class ShareProfileLoading extends UserState {}

// class UserLogoutLoading extends UserState {}

// // === Success States ===
// class UserLoadSuccess extends UserState {
//   final UserEntity user;

//   const UserLoadSuccess(this.user);

//   @override
//   List<Object?> get props => [user];
// }

// class ShareProfileSuccess extends UserState {
//   final String link;

//   const ShareProfileSuccess(this.link);

//   @override
//   List<Object?> get props => [link];
// }

// class UserLogoutSuccess extends UserState {}

// // === Error States ===
// abstract class UserErrorState extends UserState {
//   final String message;

//   const UserErrorState(this.message);

//   @override
//   List<Object?> get props => [message];
// }

// class UserLoadError extends UserErrorState {
//   const UserLoadError(super.message);
// }

// class ShareProfileError extends UserErrorState {
//   const ShareProfileError(super.message);
// }

// class UserLogoutError extends UserErrorState {
//   const UserLogoutError(super.message);
// }
