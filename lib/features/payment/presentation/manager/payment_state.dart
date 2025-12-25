part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentModeChanged extends PaymentState {
  final String mode;
  const PaymentModeChanged(this.mode);

  @override
  List<Object?> get props => [mode];
}

class PaymentSuccess extends PaymentState {
  final String? transactionId;
  const PaymentSuccess({this.transactionId});

  @override
  List<Object?> get props => [transactionId];
}

class PaymentFailure extends PaymentState {
  final String errMessage;
  const PaymentFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
