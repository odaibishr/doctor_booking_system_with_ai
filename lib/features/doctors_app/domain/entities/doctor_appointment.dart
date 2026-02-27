import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/appointment_schedule_info.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/appointment_transaction_info.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/patient_info.dart';

class DoctorAppointment {
  final int id;
  final int doctorId;
  final int userId;
  final int doctorScheduleId;
  final String date;
  final String status;
  final bool isCompleted;
  final String? cancellationReason;
  final String createdAt;
  final String updatedAt;
  final PatientInfo? patientInfo;
  final AppointmentTransactionInfo? transactionInfo;
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
