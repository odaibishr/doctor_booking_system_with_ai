import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';

class WaitlistEntry {
  final int id;
  final int userId;
  final int doctorId;
  final String? preferredDate;
  final int? preferredScheduleId;
  final String status;
  final DateTime? notifiedAt;
  final DateTime? expiresAt;
  final int position;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Doctor? doctor;

  WaitlistEntry({
    required this.id,
    required this.userId,
    required this.doctorId,
    this.preferredDate,
    this.preferredScheduleId,
    required this.status,
    this.notifiedAt,
    this.expiresAt,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
    this.doctor,
  });

  bool get isWaiting => status == 'waiting';
  bool get isNotified => status == 'notified';
  bool get isBooked => status == 'booked';
  bool get isExpired => status == 'expired';
  bool get isCancelled => status == 'cancelled';

  Duration? get timeRemaining {
    if (expiresAt == null) return null;
    final remaining = expiresAt!.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  bool get hasExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }
}
