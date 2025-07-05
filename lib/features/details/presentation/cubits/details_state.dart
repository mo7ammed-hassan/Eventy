import 'package:equatable/equatable.dart';

sealed class DetailsState extends Equatable {}

class DetailsStateInitial extends DetailsState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class JoinEventLoading extends DetailsState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class JoinEventSuccess extends DetailsState {
  final String message;

  JoinEventSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class JoinEventFailure extends DetailsState {
  final String errorMessage;

  JoinEventFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
