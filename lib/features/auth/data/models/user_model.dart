import 'package:doctor_booking_system_with_ai/core/layers/data/models/location_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/location.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.token,
    super.phone,
    super.address,
    super.profileImage,
    super.birthDate,
    super.gender,
    required super.location,
    required super.locationId,
    super.fcm_token,
  });

  factory UserModel.empty() {
    return UserModel(
      id: 0,
      name: '',
      email: '',
      token: '',
      phone: null,
      address: null,
      profileImage: null,
      birthDate: null,
      gender: null,
      location: LocationModel.empty(),
      locationId: 0,
      fcm_token: null,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final locationJson = json['location'];
    final Location location = locationJson is Map
        ? LocationModel.fromMap(
            locationJson.map((k, v) => MapEntry(k.toString(), v)),
          )
        : LocationModel.empty();

    return UserModel(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      token: json['token']?.toString() ?? '',
      phone: json['phone']?.toString(),
      address: json['address']?.toString(),
      profileImage: _normalizeNullableString(
        json['profile_image'] ?? json['profileImage'],
      ),
      birthDate: json['birth_date']?.toString() ?? json['birthDate']?.toString(),
      gender: json['gender']?.toString(),
      location: location,
      locationId: json['location_id'] ?? json['locationId'] ?? location.id,
      fcm_token: json['fcm_token']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'phone': phone,
      'address': address,
      'profile_image': profileImage,
      'birth_date': birthDate,
      'gender': gender,
      'location': location,
      'location_id': locationId,
      'fcm_token': fcm_token,
    };
  }

  static String? _normalizeNullableString(dynamic value) {
    if (value == null) return null;
    final s = value.toString().trim();
    if (s.isEmpty) return null;
    if (s.toLowerCase() == 'null') return null;
    return s;
  }
}
