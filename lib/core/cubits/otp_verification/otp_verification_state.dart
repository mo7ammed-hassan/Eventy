import 'package:equatable/equatable.dart';

abstract class OtpVerificationState extends Equatable {
  const OtpVerificationState();

  @override
  List<Object> get props => [];
}

class OtpVerificationInitial extends OtpVerificationState {}

class OtpVerificationLoading extends OtpVerificationState {}

class OtpVerificationSuccess extends OtpVerificationState {
  final String user;

  const OtpVerificationSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class OtpVerificationFailure extends OtpVerificationState {
  final String message;

  const OtpVerificationFailure(this.message);

  @override
  List<Object> get props => [message];
}

class ResndOtpSuccess extends OtpVerificationState {
  final String message;

  const ResndOtpSuccess(this.message);
}

class ResndOtpFailure extends OtpVerificationState {
  final String message;

  const ResndOtpFailure(this.message);
}

class ResndOtpLoading extends OtpVerificationState {}
