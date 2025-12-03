// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive_flutter/hive_flutter.dart';

import 'hospital.dart';
import 'location.dart';
import 'specialty.dart';

part 'doctor.g.dart';

@HiveType(typeId: 2)
class Doctor {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  String phone;
  @HiveField(4)
  String aboutus;
  @HiveField(5)
  int locationId;
  @HiveField(6)
  int specialtyId;
  @HiveField(7)
  int hospitalId;
  @HiveField(8)
  String gender;
  @HiveField(9)
  int isFeatured;
  @HiveField(10)
  int isTopDoctor;
  @HiveField(11)
  String profileImage;
  @HiveField(12)
  String birthday;
  @HiveField(13)
  String services;
  @HiveField(14)
  Location location;
  @HiveField(15)
  Specialty specialty;
  @HiveField(16)
  Hospital hospital;

  Doctor({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.aboutus,
    required this.locationId,
    required this.specialtyId,
    required this.hospitalId,
    required this.gender,
    required this.isFeatured,
    required this.isTopDoctor,
    required this.profileImage,
    required this.birthday,
    required this.services,
    required this.location,
    required this.specialty,
    required this.hospital,
  });
}
