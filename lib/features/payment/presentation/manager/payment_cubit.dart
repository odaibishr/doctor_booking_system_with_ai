import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/domain/use_cases/create_appointment_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/payment/domain/repos/payment_repo.dart';
import 'package:equatable/equatable.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepo paymentRepo;
  final CreateAppointmentUseCase createAppointmentUseCase;

  PaymentCubit({
    required this.paymentRepo,
    required this.createAppointmentUseCase,
  }) : super(PaymentInitial());

  String _selectedPaymentMode = 'cash';

  void selectPaymentMode(String mode) {
    _selectedPaymentMode = mode;
    emit(PaymentModeChanged(mode));
  }

  Future<void> bookAppointment({
    required int doctorId,
    int? doctorScheduleId,
    required String date,
    double? amount,
  }) async {
    emit(PaymentLoading());

    String? transactionId = '1';

    if (_selectedPaymentMode == 'online') {
      if (amount == null) {
        emit(
          const PaymentFailure(
            errMessage: "Amount is required for online payment",
          ),
        );
        return;
      }

      final paymentResult = await paymentRepo.processPayment(
        amount: amount,
        currency: 'USD',
      );

      paymentResult.fold(
        (failure) {
          emit(PaymentFailure(errMessage: failure.errorMessage));
        },
        (id) {
          transactionId = id;
        },
      );

      if (transactionId == null) return; // Payment failed
    }

    final appointmentResult = await createAppointmentUseCase.call(
      CreateAppointmentUseCaseParams(
        doctorId: doctorId,
        doctorScheduleId: doctorScheduleId,
        date: date,
        paymentMode: _selectedPaymentMode,
        transactionId: transactionId,
        status: 'pending',
      ),
    );

    appointmentResult.fold(
      (failure) => emit(PaymentFailure(errMessage: failure.errorMessage)),
      (appointment) => emit(PaymentSuccess(transactionId: transactionId)),
    );
  }
}
