abstract class SignupState {
  const SignupState();
}

class SignupInitial extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessState extends SignupState {
  final String message;

  const SignupSuccessState(this.message);
}

class SignupErrorState extends SignupState {
  final String message;

  const SignupErrorState(this.message);
}

class PrivacyValidationErrorState extends SignupState {
  final String errorMessage;

  const PrivacyValidationErrorState(this.errorMessage);
}

class PasswordValidationErrorState extends SignupState {
  final String errorMessage;

  const PasswordValidationErrorState(this.errorMessage);
}
