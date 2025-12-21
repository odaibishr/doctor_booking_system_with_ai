import 'package:doctor_booking_system_with_ai/core/database/api/dio_consumer.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/data/models/appointment_model.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/domain/entities/appointment.dart';

abstract class AppointmentRemoteDataSource {
  Future<Appointment> createAppointment({
    required int doctorId,
    required int doctorScheduleId,
    required int transitionId,
    required String date,
    required String time,
    required String statue,
  });
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final DioConsumer dioConsumer;

  AppointmentRemoteDataSourceImpl(this.dioConsumer);

  @override
  Future<Appointment> createAppointment({
    required int doctorId,
    required int doctorScheduleId,
    required int transitionId,
    required String date,
    required String time,
    required String statue,
  }) async {
    final response = await dioConsumer.post(
      'appointment/createAppointment',
      data: {
        'doctor_id': doctorId,
        'doctor_schedule_id': doctorScheduleId,
        'transition_id': transitionId,
        'date': date,
        'time': time,
        'statue': statue,
      },
    );
    return AppointmentModel.fromMap(response['data']);
  }
}
