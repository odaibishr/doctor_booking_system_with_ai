import 'package:hive_flutter/hive_flutter.dart';

import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';

import 'hospital.dart';
import 'location.dart';
import 'specialty.dart';
import 'doctor_schedule.dart';

part 'doctor.g.dart';

@HiveType(typeId: 2)
class Doctor {
  @HiveField(0)
  int id;

  @HiveField(1)
  String aboutus;

  @HiveField(2)
  int specialtyId;

  @HiveField(3)
  int hospitalId;

  @HiveField(4)
  int isFeatured;

  @HiveField(5)
  int isTopDoctor;

  @HiveField(6)
  List<String> services;

  @HiveField(7)
  Specialty specialty;

  @HiveField(8)
  Hospital hospital;

  @HiveField(9)
  int isFavorite;

  @HiveField(10)
  User user;

  @HiveField(11)
  double price;

  @HiveField(12)
  int experience;

  @HiveField(13)
  List<DoctorSchedule>? schedules;

  @HiveField(14)
  int newPatientDuration;

  @HiveField(15)
  int returningPatientDuration;

  Doctor({
    required this.id,
    required this.aboutus,
    required this.specialtyId,
    required this.hospitalId,
    required this.isFeatured,
    required this.isTopDoctor,
    required this.services,
    required this.specialty,
    required this.hospital,
    required this.isFavorite,
    required this.user,
    required this.price,
    required this.experience,
    this.schedules,
    this.newPatientDuration = 30,
    this.returningPatientDuration = 15,
  });

  String get name => user.name;
  String get email => user.email;
  String get phone => user.phone ?? '';
  String get profileImage => user.profileImage ?? '';
  String get gender => user.gender ?? '';
  String get birthday => user.birthDate ?? '';
  int get locationId => user.locationId;
  Location get location => user.location;
}
