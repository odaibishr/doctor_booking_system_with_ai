import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/appointment_schedule_info.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/appointment_transaction_info.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/patient_info.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'doctor_appointment.g.dart';

@HiveType(typeId: 19)
class DoctorAppointment {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int doctorId;
  @HiveField(2)
  final int userId;
  @HiveField(3)
  final int doctorScheduleId;
  @HiveField(4)
  final String date;
  @HiveField(5)
  final String status;
  @HiveField(6)
  final bool isCompleted;
  @HiveField(7)
  final String? cancellationReason;
  @HiveField(8)
  final String createdAt;
  @HiveField(9)
  final String updatedAt;
  @HiveField(10)
  final PatientInfo? patientInfo;
  @HiveField(11)
  final AppointmentTransactionInfo? transactionInfo;
  @HiveField(12)
  final AppointmentScheduleInfo? scheduleInfo;

  DoctorAppointment({
    required this.id,
    required this.doctorId,
    required this.userId,
    required this.doctorScheduleId,
    required this.date,
    required this.status,
    required this.isCompleted,
    this.cancellationReason,
    required this.createdAt,
    required this.updatedAt,
    this.patientInfo,
    this.transactionInfo,
    this.scheduleInfo,
  });
}
