import 'package:equatable/equatable.dart';
import 'package:eventy/features/personalization/domain/entities/user_entity.dart';

/// --- Unified State ---
class UserState extends Equatable {
  final UserEntity? user;
  final bool isLoading;
  final bool isSharingProfile;
  final bool isLoggingOut;
  final String? shareLink;
  final String? errorMessage;

  const UserState({
    this.user,
    this.isLoading = false,
    this.isSharingProfile = false,
    this.isLoggingOut = false,
    this.shareLink,
    this.errorMessage,
  });

  UserState copyWith({
    UserEntity? user,
    bool? isLoading,
    bool? isSharingProfile,
    bool? isLoggingOut,
    String? shareLink,
    String? errorMessage,
  }) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isSharingProfile: isSharingProfile ?? this.isSharingProfile,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
      shareLink: shareLink ?? this.shareLink,
      errorMessage: errorMessage,
    );
  }

  factory UserState.initial() => const UserState();

  @override
  List<Object?> get props => [
    user,
    isLoading,
    isSharingProfile,
    isLoggingOut,
    shareLink,
    errorMessage,
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
