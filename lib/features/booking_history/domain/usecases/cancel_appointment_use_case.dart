import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/repos/booking_history_repo.dart';

class CancelAppointmentUseCase extends Usecase<void, CancelAppointmentParams> {
  final BookingHistoryRepo bookingHistoryRepo;

  CancelAppointmentUseCase(this.bookingHistoryRepo);

  @override
  Future<Either<Failure, void>> call([CancelAppointmentParams? params]) {
    return bookingHistoryRepo.cancelAppointment(
      params!.appointmentId,
      params.reason,
    );
  }
}

class CancelAppointmentParams {
  final int appointmentId;
  final String reason;

  CancelAppointmentParams(this.appointmentId, this.reason);
}
