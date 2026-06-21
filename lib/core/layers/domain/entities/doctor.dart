// lib/core/layers/domain/entities/doctor.dart

import 'hospital.dart';
import 'location.dart';
import 'specialty.dart';
import 'doctor_schedule.dart';
import 'user.dart';

class Doctor {
  int id;
  String aboutus;
  int specialtyId;
  int hospitalId;
  int isFeatured;
  int isTopDoctor;
  List<String> services;
  Specialty specialty;
  Hospital hospital;
  int isFavorite;
  User user;
  double price;
  int experience;
  List<DoctorSchedule>? schedules;
  int newPatientDuration;
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
