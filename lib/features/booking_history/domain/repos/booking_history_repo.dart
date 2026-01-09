import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';

abstract class BookingHistoryRepo {
  Future<Either<Failure, List<Booking>>> getBookingHistory();
  Future<Either<Failure, void>> cancelAppointment(
    int appointmentId,
    String reason,
  );
}
