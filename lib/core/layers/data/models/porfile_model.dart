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
    final dynamic userJsonRaw = json['user'] ?? json['data'];
    final Map<String, dynamic> userJson = _ensureMap(
      userJsonRaw is Map ? userJsonRaw : json,
    );

    final user = userJson.isNotEmpty ? UserModel.fromJson(userJson) : UserModel.empty();

    return ProfileModel(
      phone: (json['phone'] ?? user.phone ?? '').toString(),
      birthDate: (json['birth_date'] ?? user.birthDate ?? '').toString(),
      gender: (json['gender'] ?? user.gender ?? '').toString(),
      locationId: json['location_id'] ?? user.locationId,
      profileImage: _normalizeNullableString(json['profile_image']) ?? user.profileImage,
      user: user,
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

  static Map<String, dynamic> _ensureMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return <String, dynamic>{};
  }

  static String? _normalizeNullableString(dynamic value) {
    if (value == null) return null;
    final s = value.toString().trim();
    if (s.isEmpty) return null;
    if (s.toLowerCase() == 'null') return null;
    return s;
  }
}
