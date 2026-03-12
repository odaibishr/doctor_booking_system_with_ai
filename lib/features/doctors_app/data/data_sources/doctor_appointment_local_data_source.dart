import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class DoctorAppointmentLocalDataSource {
  Future<void> cacheAppointments(
    String key,
    List<DoctorAppointment> appointments,
  );
  Future<List<DoctorAppointment>> getCachedAppointments(String key);
}

class DoctorAppointmentLocalDataSourceImpl
    implements DoctorAppointmentLocalDataSource {
  final Box<List<DoctorAppointment>> box;
  DoctorAppointmentLocalDataSourceImpl({required this.box});
  @override
  Future<void> cacheAppointments(
    String key,
    List<DoctorAppointment> appointments,
  ) async {
    await box.put(key, appointments);
  }

  @override
  Future<List<DoctorAppointment>> getCachedAppointments(String key) async {
    final data = box.get(key);
    if (data != null) {
      return data.cast<DoctorAppointment>();
    }
    return [];
  }
}
