abstract class ResetPasswordState {}

// loading
class ResetPasswordLoadingState extends ResetPasswordState {}

// success
class ResetPasswordSuccessState extends ResetPasswordState {
  final String successMessage;

  ResetPasswordSuccessState(this.successMessage);
}

// error

class ResetPasswordErrorState extends ResetPasswordState {
  final String errorMessage;

  ResetPasswordErrorState(this.errorMessage);
}

class CheckEmailLoadingState extends ResetPasswordState {}

class CheckEmailSuccessState extends ResetPasswordState {
  final String message;

  CheckEmailSuccessState(this.message);
}

class CheckEmailFailureState extends ResetPasswordState {
  final String message;

  CheckEmailFailureState(this.message);
}

class ResetPasswordValidationErrorState extends ResetPasswordState {
  final String errorMessage;

  ResetPasswordValidationErrorState(this.errorMessage);
}
