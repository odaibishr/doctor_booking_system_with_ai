// lib/core/layers/domain/entities/user.dart

import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/location.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String token;
  final String? phone;
  final String? address;
  final String? profileImage;
  final String? birthDate;
  final String? gender;
  Location location;
  final int locationId;
  final String? fcmToken;
  final String? role;
  final int? doctorId;

  User({
    this.phone,
    this.address,
    this.profileImage,
    this.birthDate,
    this.gender,
    required this.location,
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.locationId,
    this.fcmToken,
    this.role,
    this.doctorId,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? token,
    String? phone,
    String? address,
    String? profileImage,
    String? birthDate,
    String? gender,
    Location? location,
    int? locationId,
    String? fcmToken,
    String? role,
    int? doctorId,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      profileImage: profileImage ?? this.profileImage,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      locationId: locationId ?? this.locationId,
      fcmToken: fcmToken ?? this.fcmToken,
      role: role ?? this.role,
      doctorId: doctorId ?? this.doctorId,
    );
  }
}
