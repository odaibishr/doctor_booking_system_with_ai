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
