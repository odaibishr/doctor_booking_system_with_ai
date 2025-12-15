import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required super.phone,
    required super.birthDate,
    required super.gender,
    required super.locationId,
    super.profileImage,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      phone: json['phone'] as String,
      birthDate: json['birth_date'] as String,
      gender: json['gender'] as String,
      locationId: json['location_id'],
      profileImage: json['profile_image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'birth_date': birthDate,
      'gender': gender,
      'location_id': locationId,
      'profile_image': profileImage,
    };
  }
}
