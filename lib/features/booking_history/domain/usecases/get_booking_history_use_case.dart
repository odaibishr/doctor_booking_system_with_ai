import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/repos/booking_history_repo.dart';

class GetBookingHistoryUseCase
    extends Usecase<List<Booking>, NoParams> {
  final BookingHistoryRepo bookingHistoryRepo;

  GetBookingHistoryUseCase(this.bookingHistoryRepo);

  @override
  Future<Either<Failure, List<Booking>>> call([NoParams? params]) async {
    return await bookingHistoryRepo.getBookingHistory();
  }
}

class NoParams {}
