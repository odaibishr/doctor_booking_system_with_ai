import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/data/models/booking_model.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';

abstract class BookingHistoryRemoteDataSource {
  Future<List<Booking>> getBookingHistory();
  Future<void> cancelAppointment(int appointmentId, String reason);
  Future<void> rescheduleAppointment(
    int appointmentId,
    String date,
    int? scheduleId,
  );
}

class BookingHistoryRemoteDataSourceImpl
    implements BookingHistoryRemoteDataSource {
  final DioConsumer dioConsumer;

  BookingHistoryRemoteDataSourceImpl(this.dioConsumer);

  @override
  Future<List<Booking>> getBookingHistory() async {
    final response = await dioConsumer.get('appointment/getUserAppointment');
    final bookings = <Booking>[];

    if (response['data'] != null && response['data'] is List) {
      for (final booking in response['data']) {
        bookings.add(BookingModel.fromMap(booking as Map<String, dynamic>));
      }
    }

    return bookings;
  }

  @override
  Future<void> cancelAppointment(int appointmentId, String reason) async {
    await dioConsumer.put(
      'appointment/updateAppointmentStatus/$appointmentId',
      data: {'status': 'cancelled', 'cancellation_reason': reason},
    );
  }

  @override
  Future<void> rescheduleAppointment(
    int appointmentId,
    String date,
    int? scheduleId,
  ) async {
    await dioConsumer.put(
      'appointment/rescheduleAppointment/$appointmentId',
      data: {
        'date': date,
        if (scheduleId != null) 'doctor_schedule_id': scheduleId,
      },
    );
  }
}
