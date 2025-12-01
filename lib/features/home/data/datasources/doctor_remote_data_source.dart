import 'package:doctor_booking_system_with_ai/features/home/domain/entities/doctor.dart';

abstract class DoctorRemoteDataSource {
  Future<List<Doctor>> getDoctors();
}
