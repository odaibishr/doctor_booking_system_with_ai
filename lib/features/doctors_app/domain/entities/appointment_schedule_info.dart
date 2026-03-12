import 'package:hive_flutter/hive_flutter.dart';

part 'appointment_schedule_info.g.dart';

@HiveType(typeId: 18)
class AppointmentScheduleInfo {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String startTime;
  @HiveField(2)
  final String endTime;
  @HiveField(3)
  final String? dayName;

  AppointmentScheduleInfo({
    required this.id,
    required this.startTime,
    required this.endTime,
    this.dayName,
  });
}
