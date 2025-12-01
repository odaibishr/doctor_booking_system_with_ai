import 'dart:convert';

import 'hospital.dart';
import 'location.dart';
import 'specialty.dart';

class Doctor {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? aboutus;
  int? locationId;
  int? specialtyId;
  int? hospitalId;
  String? gender;
  int? isFeatured;
  int? isTopDoctor;
  String? profileImage;
  String? birthday;
  String? services;
  DateTime? createdAt;
  DateTime? updatedAt;
  Location? location;
  Specialty? specialty;
  Hospital? hospital;

  Doctor({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.aboutus,
    this.locationId,
    this.specialtyId,
    this.hospitalId,
    this.gender,
    this.isFeatured,
    this.isTopDoctor,
    this.profileImage,
    this.birthday,
    this.services,
    this.createdAt,
    this.updatedAt,
    this.location,
    this.specialty,
    this.hospital,
  });

  factory Doctor.fromMap(Map<String, dynamic> data) => Doctor(
    id: data['id'] as int?,
    name: data['name'] as String?,
    email: data['email'] as String?,
    phone: data['phone'] as String?,
    aboutus: data['aboutus'] as String?,
    locationId: data['location_id'] as int?,
    specialtyId: data['specialty_id'] as int?,
    hospitalId: data['hospital_id'] as int?,
    gender: data['gender'] as String?,
    isFeatured: data['is_featured'] as int?,
    isTopDoctor: data['is_top_doctor'] as int?,
    profileImage: data['profile_image'] as String?,
    birthday: data['birthday'] as String?,
    services: data['services'] as String?,
    createdAt: data['created_at'] == null
        ? null
        : DateTime.parse(data['created_at'] as String),
    updatedAt: data['updated_at'] == null
        ? null
        : DateTime.parse(data['updated_at'] as String),
    location: data['location'] == null
        ? null
        : Location.fromMap(data['location'] as Map<String, dynamic>),
    specialty: data['specialty'] == null
        ? null
        : Specialty.fromMap(data['specialty'] as Map<String, dynamic>),
    hospital: data['hospital'] == null
        ? null
        : Hospital.fromMap(data['hospital'] as Map<String, dynamic>),
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
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'location': location?.toMap(),
    'specialty': specialty?.toMap(),
    'hospital': hospital?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Doctor].
  factory Doctor.fromJson(String data) {
    return Doctor.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Doctor] to a JSON string.
  String toJson() => json.encode(toMap());

  Doctor copyWith({
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
    Location? location,
    Specialty? specialty,
    Hospital? hospital,
  }) {
    return Doctor(
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
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      location: location ?? this.location,
      specialty: specialty ?? this.specialty,
      hospital: hospital ?? this.hospital,
    );
  }
}
