import 'package:doctor_booking_system_with_ai/features/create_profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required super.id,
    required super.phone,
    required super.birthDate,
    required super.gender,
    required super.locationId,
    required super.userId,
  });
}
