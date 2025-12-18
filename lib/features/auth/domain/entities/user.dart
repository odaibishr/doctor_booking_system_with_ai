// lib/features/auth/domain/entities/user.dart

import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/location.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String token;

  @HiveField(4)
  final String? phone;

  @HiveField(5)
  final String? address;

  @HiveField(6)
  final String? profileImage;

  @HiveField(7)
  final String? birthDate;

  @HiveField(8)
  final String? gender;

  @HiveField(9)
  Location location;

  @HiveField(10)
  final int locationId;

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
    );
  }
}
