import 'package:hive_flutter/hive_flutter.dart';

part 'doctor_schedule.g.dart';

@HiveType(typeId: 12)
class BookingHistorySchedule {
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
  final String createdAt;
  @HiveField(6)
  final String updatedAt;

  BookingHistorySchedule({
    required this.id,
    required this.doctorId,
    required this.dayId,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
  });
}
