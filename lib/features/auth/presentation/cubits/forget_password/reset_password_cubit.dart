import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventy/config/service_locator.dart';
import 'package:eventy/features/auth/data/models/reset_passwor_model.dart';
import 'package:eventy/features/auth/domain/repositories/auth_repo.dart';
import 'package:eventy/features/auth/presentation/cubits/forget_password/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordLoadingState());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Forgot Password
  Future<void> forgetPassword() async {
    if (!validateForm()) return;

    emit(CheckEmailLoadingState());

    var result = await getIt<AuthRepo>().forgetPassword(
      email: emailController.text.trim(),
    );
    result.fold(
      (error) => emit(CheckEmailFailureState(error.message)),
      (success) =>
          emit(CheckEmailSuccessState('Password has been sent successfully.')),
    );
  }

  /// Reset Password
  Future<void> resetPassword() async {
    if (!validateForm()) return;

    if (passwordController.text != confPasswordController.text) {
      emit(
        ResetPasswordValidationErrorState(
          'Password and Confirm Password must be same',
        ),
      );
      return;
    }

    final resetModel = ResetPassworModel(
      emailController.text.trim(),
      passwordController.text.trim(),
      confPasswordController.text.trim(),
    );

    emit(ResetPasswordLoadingState());

    var result = await getIt<AuthRepo>().resetPassword(
      resetPassworModel: resetModel,
    );
    result.fold(
      (error) => emit(ResetPasswordErrorState(error.message)),
      (success) => emit(
        ResetPasswordSuccessState('Password has been reset successfully.'),
      ),
    );
  }

  // validation
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
