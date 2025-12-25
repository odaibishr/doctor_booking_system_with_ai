import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/data/models/appointment_model.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/domain/entities/appointment.dart';

abstract class AppointmentRemoteDataSource {
  Future<Appointment> createAppointment({
    required int doctorId,
    int? doctorScheduleId,
    String? transactionId,
    required String date,
    required String paymentMode,
    String? status,
    bool? isCompleted,
  });
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final DioConsumer dioConsumer;

  AppointmentRemoteDataSourceImpl(this.dioConsumer);

  @override
  Future<Appointment> createAppointment({
    required int doctorId,
    int? doctorScheduleId,
    String? transactionId,
    required String date,
    required String paymentMode,
    String? status,
    bool? isCompleted,
  }) async {
    final response = await dioConsumer.post(
      'appointment/createAppointment',
      data: {
        'doctor_id': doctorId,
        'doctor_schedule_id': doctorScheduleId,
        'transaction_id': transactionId,
        'date': date,
        'payment_mode': paymentMode,
        'status': status ?? 'pending',
        'is_completed': isCompleted ?? false,
      },
    );
    return AppointmentModel.fromMap(response['data']);
  }
}
