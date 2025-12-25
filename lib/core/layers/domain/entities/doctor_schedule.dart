import 'package:hive_flutter/hive_flutter.dart';
import 'day.dart';

part 'doctor_schedule.g.dart';

@HiveType(typeId: 11) // Unique typeId
class DoctorSchedule {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int doctorId;
  @HiveField(2)
  final int dayId;
  @HiveField(3)
  final String startTime;
  @HiveField(4)
  final String endTime;
  @HiveField(5)
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
