import 'package:doctor_booking_system_with_ai/features/waitlist/data/models/waitlist_model.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/domain/repos/waitlist_repo.dart';

abstract class WaitlistRemoteDataSource {
  Future<WaitlistModel> joinWaitlist({
    required int doctorId,
    String? preferredDate,
    int? preferredScheduleId,
  });

  Future<void> leaveWaitlist(int waitlistId);

  Future<List<WaitlistModel>> getMyWaitlists();

  Future<WaitlistPositionInfo> getPosition(int doctorId);

  Future<dynamic> acceptSlot({
    required int waitlistId,
    required String date,
    required int doctorScheduleId,
    required String paymentMode,
  });

  Future<void> declineSlot(int waitlistId);

  Future<DoctorAvailabilityInfo> checkDoctorAvailability(int doctorId);
}
