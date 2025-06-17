import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventy/core/cubits/password_and_selection/password_and_selection_state.dart';

class PasswordAndSelectionCubit extends Cubit<PasswordAndSelectionState> {
  PasswordAndSelectionCubit()
    : super(
        PasswordAndSelectionState(
          isPasswordHidden: true,
          isPrivacyAccepted: false,
          isRememberMe: false,
          isConfirmPasswordHidden: true,
        ),
      );

  // Toggle password visibility
  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
  }

  // Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    emit(
      state.copyWith(isConfirmPasswordHidden: !state.isConfirmPasswordHidden),
    );
  }

  // Toggle Privacy Acceptance
  void togglePrivacyAcceptance() {
    emit(state.copyWith(isPrivacyAccepted: !state.isPrivacyAccepted));
  }

  // Toggle Remember Me
  void toggleRememberMe() {
    emit(state.copyWith(isRememberMe: !state.isRememberMe));
  }
}
