import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_day_off.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class DoctorProfileLocalDataSource {
  Future<void> cacheMyProfile(Doctor profile);
  Future<Doctor?> getCachedMyProfile();

  Future<void> cacheSchedules(List<DoctorSchedule> schedules);
  Future<List<DoctorSchedule>> getCachedSchedules();

  Future<void> cacheDaysOff(List<DoctorDayOff> daysOff);
  Future<List<DoctorDayOff>> getCachedDaysOff();
}

class DoctorProfileLocalDataSourceImpl implements DoctorProfileLocalDataSource {
  final Box<Doctor> profileBox;
  final Box<List<DoctorSchedule>> schedulesBox;
  final Box<List<DoctorDayOff>> daysOffBox;

  DoctorProfileLocalDataSourceImpl({
    required this.profileBox,
    required this.schedulesBox,
    required this.daysOffBox,
  });

  @override
  Future<void> cacheMyProfile(Doctor profile) async {
    await profileBox.put('my_profile', profile);
  }

  @override
  Future<Doctor?> getCachedMyProfile() async {
    return profileBox.get('my_profile');
  }

  @override
  Future<void> cacheSchedules(List<DoctorSchedule> schedules) async {
    await schedulesBox.put('my_schedules', schedules);
  }

  @override
  Future<List<DoctorSchedule>> getCachedSchedules() async {
    final data = schedulesBox.get('my_schedules');
    if (data != null) {
      return data.cast<DoctorSchedule>();
    }
    return [];
  }

  @override
  Future<void> cacheDaysOff(List<DoctorDayOff> daysOff) async {
    await daysOffBox.put('my_days_off', daysOff);
  }

  @override
  Future<List<DoctorDayOff>> getCachedDaysOff() async {
    final data = daysOffBox.get('my_days_off');
    if (data != null) {
      return data.cast<DoctorDayOff>();
    }
    return [];
  }
}
