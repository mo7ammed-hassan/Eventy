class PasswordAndSelectionState {
  final bool isPasswordHidden;
  final bool isPrivacyAccepted;
  final bool isRememberMe;
  final bool isConfirmPasswordHidden;

  PasswordAndSelectionState({
    required this.isPasswordHidden,
    required this.isPrivacyAccepted,
    required this.isRememberMe,
    required this.isConfirmPasswordHidden,
  });

  PasswordAndSelectionState copyWith({
    bool? isPasswordHidden,
    bool? isPrivacyAccepted,
    bool? isRememberMe,
    bool? isConfirmPasswordHidden,
  }) {
    return PasswordAndSelectionState(
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isPrivacyAccepted: isPrivacyAccepted ?? this.isPrivacyAccepted,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      isConfirmPasswordHidden:
          isConfirmPasswordHidden ?? this.isConfirmPasswordHidden,
    );
  }
}
