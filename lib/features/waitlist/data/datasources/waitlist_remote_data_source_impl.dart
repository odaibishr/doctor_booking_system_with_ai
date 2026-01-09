import 'package:dio/dio.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/data/datasources/waitlist_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/data/models/waitlist_model.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/domain/repos/waitlist_repo.dart';

class WaitlistRemoteDataSourceImpl implements WaitlistRemoteDataSource {
  final Dio dio;

  WaitlistRemoteDataSourceImpl({required this.dio});

  @override
  Future<WaitlistModel> joinWaitlist({
    required int doctorId,
    String? preferredDate,
    int? preferredScheduleId,
  }) async {
    final response = await dio.post(
      '${EndPoints.baseUrl}waitlist/join',
      data: {
        'doctor_id': doctorId,
        if (preferredDate != null) 'preferred_date': preferredDate,
        if (preferredScheduleId != null)
          'preferred_schedule_id': preferredScheduleId,
      },
    );

    final data = response.data['data'];
    return WaitlistModel.fromJson(data['waitlist'] as Map<String, dynamic>);
  }

  @override
  Future<void> leaveWaitlist(int waitlistId) async {
    await dio.delete('${EndPoints.baseUrl}waitlist/leave/$waitlistId');
  }

  @override
  Future<List<WaitlistModel>> getMyWaitlists() async {
    final response = await dio.get('${EndPoints.baseUrl}waitlist/my-waitlists');

    final data = response.data['data'] as List<dynamic>;
    return data
        .map((e) => WaitlistModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<WaitlistPositionInfo> getPosition(int doctorId) async {
    final response = await dio.get(
      '${EndPoints.baseUrl}waitlist/position/$doctorId',
    );

    final data = response.data['data'] as Map<String, dynamic>;
    return WaitlistPositionInfo(
      inWaitlist: data['in_waitlist'] as bool,
      position: data['position'] as int?,
      waitlistEntry: data['waitlist'] != null
          ? WaitlistModel.fromJson(data['waitlist'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  Future<dynamic> acceptSlot({
    required int waitlistId,
    required String date,
    required int doctorScheduleId,
    required String paymentMode,
  }) async {
    final response = await dio.post(
      '${EndPoints.baseUrl}waitlist/accept/$waitlistId',
      data: {
        'date': date,
        'doctor_schedule_id': doctorScheduleId,
        'payment_mode': paymentMode,
      },
    );

    return response.data['data'];
  }

  @override
  Future<void> declineSlot(int waitlistId) async {
    await dio.post('${EndPoints.baseUrl}waitlist/decline/$waitlistId');
  }

  @override
  Future<DoctorAvailabilityInfo> checkDoctorAvailability(int doctorId) async {
    final response = await dio.get(
      '${EndPoints.baseUrl}waitlist/check-availability/$doctorId',
    );

    final data = response.data['data'] as Map<String, dynamic>;
    return DoctorAvailabilityInfo(
      hasAvailableSlots: data['has_available_slots'] as bool,
      canJoinWaitlist: data['can_join_waitlist'] as bool,
      userInWaitlist: data['user_in_waitlist'] as bool,
      userWaitlistEntry: data['user_waitlist_entry'] != null
          ? WaitlistModel.fromJson(
              data['user_waitlist_entry'] as Map<String, dynamic>,
            )
          : null,
      waitlistCount: data['waitlist_count'] as int,
    );
  }
}
