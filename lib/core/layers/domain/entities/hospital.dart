// lib/core/layers/domain/entities/hospital.dart

import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/location.dart';

class Hospital {
  int id;
  String name;
  String phone;
  String email;
  String website;
  String address;
  String image;
  int locationId;
  List<Doctor>? doctors;
  String? description;
  Location? location;

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
    this.description,
    this.location,
  });
}
