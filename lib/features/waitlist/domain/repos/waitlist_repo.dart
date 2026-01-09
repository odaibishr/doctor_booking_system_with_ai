import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/domain/entities/waitlist_entry.dart';

abstract class WaitlistRepo {
  Future<Either<Failure, WaitlistEntry>> joinWaitlist({
    required int doctorId,
    String? preferredDate,
    int? preferredScheduleId,
  });

  Future<Either<Failure, void>> leaveWaitlist(int waitlistId);

  Future<Either<Failure, List<WaitlistEntry>>> getMyWaitlists();

  Future<Either<Failure, WaitlistPositionInfo>> getPosition(int doctorId);

  Future<Either<Failure, dynamic>> acceptSlot({
    required int waitlistId,
    required String date,
    required int doctorScheduleId,
    required String paymentMode,
  });

  Future<Either<Failure, void>> declineSlot(int waitlistId);

  Future<Either<Failure, DoctorAvailabilityInfo>> checkDoctorAvailability(
    int doctorId,
  );
}

class WaitlistPositionInfo {
  final bool inWaitlist;
  final int? position;
  final WaitlistEntry? waitlistEntry;

  WaitlistPositionInfo({
    required this.inWaitlist,
    this.position,
    this.waitlistEntry,
  });
}

class DoctorAvailabilityInfo {
  final bool hasAvailableSlots;
  final bool canJoinWaitlist;
  final bool userInWaitlist;
  final WaitlistEntry? userWaitlistEntry;
  final int waitlistCount;

  DoctorAvailabilityInfo({
    required this.hasAvailableSlots,
    required this.canJoinWaitlist,
    required this.userInWaitlist,
    this.userWaitlistEntry,
    required this.waitlistCount,
  });
}
