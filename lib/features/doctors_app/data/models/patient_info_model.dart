import 'package:doctor_booking_system_with_ai/core/utils/parse_helpers.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/patient_info.dart';

class PatientInfoModel extends PatientInfo {
  PatientInfoModel({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    super.profileImage,
    super.gender,
  });

  factory PatientInfoModel.fromMap(Map<String, dynamic> map) {
    return PatientInfoModel(
      id: parseToInt(map['id']),
      name: (map['name'] ?? '').toString(),
      email: (map['email'] ?? '').toString(),
      phone: map['phone']?.toString(),
      profileImage:
          map['profile_image_url']?.toString() ??
          map['profile_image']?.toString(),
      gender: map['gender']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profile_image': profileImage,
      'gender': gender,
    };
  }
}
