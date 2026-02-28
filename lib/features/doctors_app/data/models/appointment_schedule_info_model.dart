import 'package:doctor_booking_system_with_ai/core/utils/parse_helpers.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/appointment_schedule_info.dart';

class AppointmentScheduleInfoModel extends AppointmentScheduleInfo {
  AppointmentScheduleInfoModel({
    required super.id,
    required super.startTime,
    required super.endTime,
    super.dayName,
  });

  factory AppointmentScheduleInfoModel.fromMap(Map<String, dynamic> map) {
    final dayMap = map['day'];
    String? dayName;
    if (dayMap is Map) {
      dayName = (dayMap['name'] ?? dayMap['day_name'])?.toString();
    }
    return AppointmentScheduleInfoModel(
      id: parseToInt(map['id']),
      startTime: (map['start_time'] ?? '').toString(),
      endTime: (map['end_time'] ?? '').toString(),
      dayName: dayName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'start_time': startTime,
      'end_time': endTime,
      'day': dayName,
    };
  }
}
