import 'package:doctor_booking_system_with_ai/features/create_profile/domain/entities/profile.dart';

abstract class ProfileRemoteDataSource {
  Future<Profile> createProfile({
    required String phone,
    required String birthDate,
    required String gender,
    required int locationId,
  });
}

