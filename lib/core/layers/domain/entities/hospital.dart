import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hospital.g.dart';

@HiveType(typeId: 3)
class Hospital {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String email;

  @HiveField(4)
  String website;

  @HiveField(5)
  String address;

  @HiveField(6)
  String image;

  @HiveField(7)
  int locationId;

  @HiveField(8)
  List<Doctor>? doctors;

  Hospital({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.website,
    required this.address,
    required this.image,
    required this.locationId,
    this.doctors,
  });
}
