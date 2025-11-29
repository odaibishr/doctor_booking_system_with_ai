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

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      phone: json['phone'],
      birthDate: json['birth_date'],
      gender: json['gender'],
      locationId: json['location_id'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'birth_date': birthDate,
      'gender': gender,
      'location_id': locationId,
      'user_id': userId,
    };
  }
}
