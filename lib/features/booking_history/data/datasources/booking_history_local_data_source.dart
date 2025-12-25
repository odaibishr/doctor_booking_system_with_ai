import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class BookingHistoryLocalDataSource {
  Future<void> cachedBookingHistory(List<Booking> bookings);
  Future<List<Booking>> getCachedBookingHistory();
}

class BookingHistoryLocalDataSourceImpl
    implements BookingHistoryLocalDataSource {
  final Box<Booking> bookingBox;

  BookingHistoryLocalDataSourceImpl(this.bookingBox);

  @override
  Future<void> cachedBookingHistory(List<Booking> bookings) async {
    await bookingBox.clear();
    for (final booking in bookings) {
      await bookingBox.put(booking.id, booking);
    }
  }

  @override
  Future<List<Booking>> getCachedBookingHistory() async {
    return bookingBox.values.toList();
  }
}
