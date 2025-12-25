import 'package:doctor_booking_system_with_ai/features/appointment/domain/entities/appointment.dart';

class AppointmentModel extends Appointment {
  AppointmentModel({
    required super.id,
    required super.doctorId,
    super.doctorScheduleId,
    super.transactionId,
    required super.date,
    required super.paymentMode,
    required super.status,
    super.isCompleted,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      doctorId: json['doctor_id'],
      doctorScheduleId: json['doctor_schedule_id'],
      transactionId: json['transaction_id']?.toString() ?? '1',
      date: json['date'],
      paymentMode: json['payment_mode'] ?? 'cash',
      status: json['status'] ?? 'pending',
      isCompleted: json['is_completed'] == 1 || json['is_completed'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'doctor_schedule_id': doctorScheduleId,
      'transaction_id': transactionId,
      'date': date,
      'payment_mode': paymentMode,
      'status': status,
      'is_completed': isCompleted,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'],
      doctorId: map['doctor_id'],
      doctorScheduleId: map['doctor_schedule_id'],
      transactionId: map['transaction_id']?.toString() ?? '1',
      date: map['date'],
      paymentMode: map['payment_mode'] ?? 'cash',
      status: map['status'] ?? 'pending',
      isCompleted: map['is_completed'] == 1 || map['is_completed'] == true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'doctor_schedule_id': doctorScheduleId,
      'transaction_id': transactionId,
      'date': date,
      'payment_mode': paymentMode,
      'status': status,
      'is_completed': isCompleted,
    };
  }
}
