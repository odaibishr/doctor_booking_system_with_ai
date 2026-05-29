import 'package:doctor_booking_system_with_ai/features/booking_history/domain/repos/booking_history_repo.dart';

class RefreshBookingHistoryUseCase {
  final BookingHistoryRepo bookingHistoryRepo;

  RefreshBookingHistoryUseCase(this.bookingHistoryRepo);

  Future<void> call() async {
    await bookingHistoryRepo.refreshBookingHistory();
  }
}
