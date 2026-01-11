import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'booking_transaction.dart';
import 'doctor_schedule.dart';
part 'booking.g.dart';

@HiveType(typeId: 6)
class Booking {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int doctorId;
  @HiveField(2)
  final int userId;
  @HiveField(3)
  final int doctorScheduleId;
  @HiveField(4)
  final int transactionId;
  @HiveField(5)
  final String date;
  @HiveField(6)
  final String status;
  @HiveField(7)
  final bool isCompleted;
  @HiveField(8)
  final String paymentMode;
  @HiveField(9)
  final String createdAt;
  @HiveField(10)
  final String updatedAt;
  @HiveField(11)
  final Doctor doctor;
  @HiveField(12)
  final BookingHistorySchedule schedule;
  @HiveField(13)
  final BookingTransaction transaction;
  @HiveField(14)
  final bool isReturning;

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
    required this.isReturning,
  });
}
