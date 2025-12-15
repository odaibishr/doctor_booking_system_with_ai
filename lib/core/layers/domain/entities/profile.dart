import 'package:hive_flutter/hive_flutter.dart';
part 'profile.g.dart';

@HiveType(typeId: 1)
class Profile {
  @HiveField(0)
  final String phone;
  @HiveField(1)
  final String birthDate;
  @HiveField(2)
  final String gender;
  @HiveField(3)
  final int locationId;
  @HiveField(4)
  final String? profileImage;

  Profile({
    required this.phone,
    required this.birthDate,
    required this.gender,
    required this.locationId,
    this.profileImage,
  });
}
