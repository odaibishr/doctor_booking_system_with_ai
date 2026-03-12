import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/day.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'doctor_day_off.g.dart';

@HiveType(typeId: 20)
class DoctorDayOff extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int doctorId;
  @HiveField(2)
  final int dayId;
  @HiveField(3)
  final Day? day;

  DoctorDayOff({
    required this.id,
    required this.doctorId,
    required this.dayId,
    this.day,
  });

  factory DoctorDayOff.fromMap(Map<String, dynamic> map) {
    return DoctorDayOff(
      id: map['id'] ?? 0,
      doctorId: map['doctor_id'] ?? 0,
      dayId: map['day_id'] ?? 0,
      day: map['day'] != null
          ? Day(
              id: map['day']['id'] ?? 0,
              dayName: map['day']['day_name'] ?? '',
              shortName: map['day']['short_name'] ?? '',
              dayNumber: map['day']['day_number'] ?? 0,
            )
          : null,
    );
  }
}
