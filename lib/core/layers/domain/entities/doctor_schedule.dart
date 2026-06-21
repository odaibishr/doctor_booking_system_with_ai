// lib/core/layers/domain/entities/doctor_schedule.dart

import 'day.dart';

class DoctorSchedule {
  final int id;
  final int doctorId;
  final int dayId;
  final String startTime;
  final String endTime;
  final Day? day;

  DoctorSchedule({
    required this.id,
    required this.doctorId,
    required this.dayId,
    required this.startTime,
    required this.endTime,
    this.day,
  });
}
