import 'package:doctor_booking_system_with_ai/features/home/domain/entities/doctor.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class DoctorLocalDataSource {
  Future<List<Doctor>> getCachedDoctors();
  Future<void> cachedDoctors(List<Doctor> doctors);
}

class DoctorLocalDataSourceImpl implements DoctorLocalDataSource {
  final Box<Doctor> doctorBox;

  DoctorLocalDataSourceImpl(this.doctorBox);

  @override
  Future<List<Doctor>> getCachedDoctors() async {
    return doctorBox.values.toList();
  }

  @override
  Future<void> cachedDoctors(List<Doctor> doctors) async {
    await doctorBox.clear();
    for (final doctor in doctors) {
      await doctorBox.put(doctor.id, doctor);
    }
  }
}
