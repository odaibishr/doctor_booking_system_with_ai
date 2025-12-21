import 'package:doctor_booking_system_with_ai/features/appointment/domain/entities/appointment.dart';

class AppointmentModel extends Appointment {
  AppointmentModel({
    required super.id,
    required super.doctorId,
    required super.doctorScheduleId,
    required super.transitionId,
    required super.date,
    required super.time,
    required super.statue,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      doctorId: json['doctor_id'],
      doctorScheduleId: json['doctor_schedule_id'],
      transitionId: json['transition_id'],
      date: json['date'],
      time: json['time'],
      statue: json['statue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'doctor_schedule_id': doctorScheduleId,
      'transition_id': transitionId,
      'date': date,
      'time': time,
      'statue': statue,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'],
      doctorId: map['doctor_id'],
      doctorScheduleId: map['doctor_schedule_id'],
      transitionId: map['transition_id'],
      date: map['date'],
      time: map['time'],
      statue: map['statue'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'doctor_schedule_id': doctorScheduleId,
      'transition_id': transitionId,
      'date': date,
      'time': time,
      'statue': statue,
    };
  }
}
