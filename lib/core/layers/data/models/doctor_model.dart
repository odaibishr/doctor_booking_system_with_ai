import 'dart:convert';

import 'package:doctor_booking_system_with_ai/core/layers/data/models/hospital_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/location_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/specialty_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';

class DoctorModel extends Doctor {
  DoctorModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.aboutus,
    required super.locationId,
    required super.specialtyId,
    required super.hospitalId,
    required super.gender,
    required super.isFeatured,
    required super.isTopDoctor,
    required super.profileImage,
    required super.birthday,
    required super.services,
    required super.location,
    required super.specialty,
    required super.hospital,
    required super.isFavorite,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> data) => DoctorModel(
  id: data['id'] ?? 0,
  name: data['name'] ?? '',
  email: data['email'] ?? '',
  phone: data['phone'] ?? '',
  aboutus: data['aboutus'] ?? '',
  locationId: data['location_id'] ?? 0,
  specialtyId: data['specialty_id'] ?? 0,
  hospitalId: data['hospital_id'] ?? 0,
  gender: data['gender'] ?? '',
  isFeatured: data['is_featured'] ?? 0,
  isTopDoctor: data['is_top_doctor'] ?? 0,
  profileImage: data['profile_image'] ?? '',
  birthday: data['birthday'] ?? '',
  services: data['services'] ?? '',

  location: data['location'] != null
      ? LocationModel.fromMap(data['location'])
      : LocationModel.empty(),

  specialty: data['specialty'] != null
      ? SpecialtyModel.fromMap(data['specialty'])
      : SpecialtyModel.empty(),

  hospital: data['hospital'] != null
      ? HospitalModel.fromMap(data['hospital'])
      : HospitalModel.empty(),

  isFavorite: data['is_favorite'] ?? 0,
);



  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'aboutus': aboutus,
    'location_id': locationId,
    'specialty_id': specialtyId,
    'hospital_id': hospitalId,
    'gender': gender,
    'is_featured': isFeatured,
    'is_top_doctor': isTopDoctor,
    'profile_image': profileImage,
    'birthday': birthday,
    'services': services,
    'location': location,
    'specialty': specialty,
    'hospital': hospital,
    'is_favorite': isFavorite,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DoctorModel].
  factory DoctorModel.fromJson(String data) {
    return DoctorModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DoctorModel] to a JSON string.
  String toJson() => json.encode(toMap());

  DoctorModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? aboutus,
    int? locationId,
    int? specialtyId,
    int? hospitalId,
    String? gender,
    int? isFeatured,
    int? isTopDoctor,
    String? profileImage,
    String? birthday,
    String? services,
    DateTime? createdAt,
    DateTime? updatedAt,
    LocationModel? location,
    SpecialtyModel? specialty,
    HospitalModel? hospital,
    int? isFavorite,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      aboutus: aboutus ?? this.aboutus,
      locationId: locationId ?? this.locationId,
      specialtyId: specialtyId ?? this.specialtyId,
      hospitalId: hospitalId ?? this.hospitalId,
      gender: gender ?? this.gender,
      isFeatured: isFeatured ?? this.isFeatured,
      isTopDoctor: isTopDoctor ?? this.isTopDoctor,
      profileImage: profileImage ?? this.profileImage,
      birthday: birthday ?? this.birthday,
      services: services ?? this.services,
      location: location ?? this.location,
      specialty: specialty ?? this.specialty,
      hospital: hospital ?? this.hospital,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
