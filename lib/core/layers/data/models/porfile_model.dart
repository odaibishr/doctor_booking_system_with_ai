import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/profile.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/models/user_model.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required super.phone,
    required super.birthDate,
    required super.gender,
    required super.locationId,
    super.profileImage,
    required super.user,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      phone: json['phone']?.toString() ?? '',
      birthDate: json['birth_date']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      locationId: json['location_id'] ?? 0,
      profileImage: json['profile_image']?.toString(),
      user: json['user'] != null
          ? UserModel.fromJson(json['user'])
          : UserModel.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'birth_date': birthDate,
      'gender': gender,
      'location_id': locationId,
      'profile_image': profileImage,
      'user': user,
    };
  }
}
