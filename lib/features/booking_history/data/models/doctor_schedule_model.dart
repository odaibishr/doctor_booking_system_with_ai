import 'dart:convert';

import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/doctor_schedule.dart';

class DoctorScheduleModel extends BookingHistorySchedule {
  DoctorScheduleModel({
    required super.id,
    required super.doctorId,
    required super.dayId,
    required super.startTime,
    required super.endTime,
    required super.createdAt,
    required super.updatedAt,
  });

  factory DoctorScheduleModel.fromMap(Map<String, dynamic> data) =>
      DoctorScheduleModel(
        id: data['id'] ?? 0,
        doctorId: data['doctor_id'] ?? 0,
        dayId: data['day_id'] ?? 0,
        startTime: data['start_time'] ?? '',
        endTime: data['end_time'] ?? '',
        createdAt: data['created_at'] ?? '',
        updatedAt: data['updated_at'] ?? '',
      );

  Map<String, dynamic> toMap() => {
    'id': id,
    'doctor_id': doctorId,
    'day_id': dayId,
    'start_time': startTime,
    'end_time': endTime,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  factory DoctorScheduleModel.fromJson(String data) {
    return DoctorScheduleModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  String toJson() => json.encode(toMap());

  DoctorScheduleModel copyWith({
    int? id,
    int? doctorId,
    int? dayId,
    String? startTime,
    String? endTime,
    String? createdAt,
    String? updatedAt,
  }) {
    return DoctorScheduleModel(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      dayId: dayId ?? this.dayId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory DoctorScheduleModel.empty() => DoctorScheduleModel(
    id: 0,
    doctorId: 0,
    dayId: 0,
    startTime: '',
    endTime: '',
    createdAt: '',
    updatedAt: '',
  );
}
