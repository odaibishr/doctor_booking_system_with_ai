import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/repos/booking_history_repo.dart';

class WatchBookingHistoryUseCase {
  final BookingHistoryRepo bookingHistoryRepo;

  WatchBookingHistoryUseCase(this.bookingHistoryRepo);

  Stream<Either<Failure, List<Booking>>> call() {
    return bookingHistoryRepo.watchBookingHistory();
  }
}
