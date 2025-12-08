import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';

abstract class HospitalLocalDataSource {
  Future<List<Hospital>> getCachedHospitals();
}

