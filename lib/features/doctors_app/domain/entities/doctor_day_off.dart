import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/day.dart';

class DoctorDayOff {
  final int id;
  final int doctorId;
  final int dayId;
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
