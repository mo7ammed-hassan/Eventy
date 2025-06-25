import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/network/api_client.dart';
import 'package:eventy/core/network/api_service.dart';
import 'package:eventy/core/cubits/otp_verification/otp_verification_state.dart';
import 'package:eventy/features/auth/domain/repositories/auth_repo.dart'
    as auth_repo;

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  final auth_repo.AuthRepo authRepo;
  final String email;
  final ApiServices apiService = ApiServices(ApiClient());

  OtpVerificationCubit({required this.authRepo, required this.email})
    : super(OtpVerificationInitial());

  Future<void> verifyOtp(String verificationCode, {bool reset = false}) async {
    emit(OtpVerificationLoading());
    try {
      final Either<dynamic, dynamic> result;
      if (!reset) {
        final confirmCode = int.tryParse(verificationCode.trim()) ?? 0;

        result = await authRepo.verifyUser(email: email, otp: confirmCode);
      } else {
        final confirmCode = int.tryParse(verificationCode.trim()) ?? 0;

        await apiService.verifyResetPassword(email, confirmCode);
        
        // Since verifyResetPassword returns void, emit success directly
        emit(const OtpVerificationSuccess('Verification successful'));
        return;
      }

      result.fold(
        (failure) => emit(OtpVerificationFailure(failure.message)),
        (user) => emit(const OtpVerificationSuccess('Verification successful')),
      );
    } catch (e) {
      emit(
        const OtpVerificationFailure(
          'An unexpected error occurred. Please try again.',
        ),
      );
    }
  }

  Future<void> resendOtp(String email, {bool reset = false}) async {
    emit(ResndOtpLoading());
    var result = await getIt.get<auth_repo.AuthRepo>().sendOTP(email: email);
    result.fold((failure) => emit(ResndOtpFailure(failure.message)), (_) {
      emit(const ResndOtpSuccess('OTP sent successfully'));
    });
  }
}
