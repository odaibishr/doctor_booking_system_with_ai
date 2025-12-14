import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';

import 'booking_transaction.dart';
import 'doctor_schedule.dart';

class Booking {
  final int id;
  final int doctorId;
  final int userId;
  final int doctorScheduleId;
  final int transactionId;
  final String date;
  final String status;
  final bool isCompleted;
  final String paymentMode;
  final String createdAt;
  final String updatedAt;
  final Doctor doctor;
  final DoctorSchedule schedule;
  final BookingTransaction transaction;

  Booking({
    required this.id,
    required this.doctorId,
    required this.userId,
    required this.doctorScheduleId,
    required this.transactionId,
    required this.date,
    required this.status,
    required this.isCompleted,
    required this.paymentMode,
    required this.createdAt,
    required this.updatedAt,
    required this.doctor,
    required this.schedule,
    required this.transaction,
  });
}
