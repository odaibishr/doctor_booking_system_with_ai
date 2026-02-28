import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';

abstract class DoctorAppointmentRemoteDataSource {
  Future<List<DoctorAppointment>> getAppointments({
    String? status,
    String? date,
  });
}