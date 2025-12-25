import 'package:doctor_booking_system_with_ai/core/layers/data/models/day_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';

class DoctorScheduleModel extends DoctorSchedule {
  DoctorScheduleModel({
    required super.id,
    required super.doctorId,
    required super.dayId,
    required super.startTime,
    required super.endTime,
    super.day,
  });

  factory DoctorScheduleModel.fromMap(Map<String, dynamic> map) {
    return DoctorScheduleModel(
      id: map['id'] ?? 0,
      doctorId: map['doctor_id'] ?? 0,
      dayId: map['day_id'] ?? 0,
      startTime: map['start_time'] ?? '',
      endTime: map['end_time'] ?? '',
      day: map['day'] != null ? DayModel.fromMap(map['day']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'day_id': dayId,
      'start_time': startTime,
      'end_time': endTime,
      'day': day is DayModel ? (day as DayModel).toMap() : null,
    };
  }
}
