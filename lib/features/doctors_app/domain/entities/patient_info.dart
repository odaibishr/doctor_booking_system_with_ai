import 'package:hive_flutter/hive_flutter.dart';

part 'patient_info.g.dart';

@HiveType(typeId: 16)
class PatientInfo {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String? phone;
  @HiveField(4)
  final String? profileImage;
  @HiveField(5)
  final String? gender;

  PatientInfo({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.profileImage,
    this.gender,
  });
}
