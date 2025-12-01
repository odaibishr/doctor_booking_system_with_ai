// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'hospital.dart';
import 'location.dart';
import 'specialty.dart';

class Doctor {
  int id;
  String name;
  String email;
  String phone;
  String aboutus;
  int locationId;
  int specialtyId;
  int hospitalId;
  String gender;
  int isFeatured;
  int isTopDoctor;
  String profileImage;
  String birthday;
  String services;
  Location location;
  Specialty specialty;
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
