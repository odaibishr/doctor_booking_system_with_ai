import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/repos/booking_history_repo.dart';

class RescheduleAppointmentUseCase
    extends Usecase<void, RescheduleAppointmentParams> {
  final BookingHistoryRepo bookingHistoryRepo;

  RescheduleAppointmentUseCase(this.bookingHistoryRepo);

  @override
  Future<Either<Failure, void>> call([RescheduleAppointmentParams? params]) {
    return bookingHistoryRepo.rescheduleAppointment(
      params!.appointmentId,
      params.date,
      params.scheduleId,
    );
  }
}

class RescheduleAppointmentParams {
  final int appointmentId;
  final String date;
  final int? scheduleId;

  RescheduleAppointmentParams({
    required this.appointmentId,
    required this.date,
    this.scheduleId,
  });
}
