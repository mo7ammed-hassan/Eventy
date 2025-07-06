import 'dart:async';
import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/storage/secure_storage.dart';
import 'package:eventy/features/home/presentation/cubits/home_cubit.dart';
import 'package:eventy/features/user_events/user_events_injection.dart';
import 'package:flutter/material.dart';
import 'package:eventy/features/auth/data/models/login_model.dart';
import 'package:eventy/features/auth/domain/repositories/auth_repo.dart';
import 'package:eventy/features/auth/presentation/cubits/signin_cubit/signin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepo authRepo;

  SignInCubit({required this.authRepo}) : super(SignInInitial()) {
    getStorageEmailAndPassword();
  }

  // controllers
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Storage
  final SecureStorage _storage = getIt.get<SecureStorage>();

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // show email and password that is storage in get storage
  Future<void> getStorageEmailAndPassword() async {
    final email = await _storage.readKey(key: 'REMEMBER_ME_EMAIL');
    final password = await _storage.readKey(key: 'REMEMBER_ME_PASSWORD');

    emailController.text = email ?? '';
    passwordController.text = password ?? '';
  }

  Future<void> signInWithEmailAndPassword(bool isRememberMe) async {
    if (!validateForm()) return;

    emit(SignInLoading());

    // handle remember me
    if (isRememberMe) {
      _storage.saveKey(
        key: 'REMEMBER_ME_EMAIL',
        value: emailController.text.trim(),
      );
      _storage.saveKey(
        key: 'REMEMBER_ME_PASSWORD',
        value: passwordController.text.trim(),
      );
    } else {
      _storage.deleteKey(key: 'REMEMBER_ME_EMAIL');
      _storage.deleteKey(key: 'REMEMBER_ME_PASSWORD');
    }

    // Construct user creation model
    final user = LoginModel(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    final result = await authRepo.login(loginModel: user);

    result.fold((failure) => emit(SignInFailure(message: failure.toString())), (
      autData,
    ) async {
      await _storage.saveAuthData(
        accessToken: autData.accessToken,
        userId: autData.user.id,
      );
      registerUserEventsCubits(getIt);
      if (!getIt.isRegistered<HomeCubit>()) {
        getIt.registerLazySingleton<HomeCubit>(
          () => HomeCubit(getIt(), getIt()),
        );
      }
      emit(const SignInSuccess('Successfully Login in'));
    });
  }

  Future<void> signinWithGoogle() async {
    emit(SignInLoading());

    final result = await authRepo.signInWithGoogle();

    result.fold((failure) => emit(SignInFailure(message: failure.toString())), (
      _,
    ) {
      emit(const SignInSuccess('Successfully Login in'));
    });
  }

  Future<void> signinWithFacebook() async {
    emit(SignInLoading());

    final result = await authRepo.signInWithFacebook();

    result.fold((failure) => emit(SignInFailure(message: failure.toString())), (
      _,
    ) {
      ();
      emit(const SignInSuccess('Successfully Login in'));
    });
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
