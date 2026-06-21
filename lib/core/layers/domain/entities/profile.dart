// lib/core/layers/domain/entities/profile.dart

import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/user.dart';

class Profile {
  final String phone;
  final String birthDate;
  final String gender;
  final int locationId;
  final String? profileImage;
  final User user;

  Profile({
    required this.phone,
    required this.birthDate,
    required this.gender,
    required this.locationId,
    this.profileImage,
    required this.user,
  });
}
