import 'dart:convert';

import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/doctor_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';

class HospitalModel extends Hospital {
  HospitalModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.email,
    required super.website,
    required super.address,
    required super.image,
    required super.locationId,
    required super.doctors,
    required super.description,
  });

  factory HospitalModel.fromMap(Map<String, dynamic> data) => HospitalModel(
    id: data['id'] as int,
    name: data['name'] as String,
    phone: data['phone'] as String,
    email: data['email'] as String,
    website: data['website'] as String,
    address: data['address'] as String,
    image: data['image'] as String,
    locationId: data['location_id'] as int,
    doctors: (data['doctors'] as List<dynamic>?)
            ?.map(
              (doctor) => DoctorModel.fromMap(
                doctor as Map<String, dynamic>,
              ),
            )
            .toList() ??
        <Doctor>[],
    description: data['description'] ?? '',
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'website': website,
    'address': address,
    'image': image,
    'location_id': locationId,
    'doctors': doctors,
    'description': description,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Hospital].
  factory HospitalModel.fromJson(String data) {
    return HospitalModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Hospital] to a JSON string.
  String toJson() => json.encode(toMap());

  HospitalModel copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? website,
    String? address,
    String? image,
    int? locationId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Doctor>? doctors,
    String? description,
  }) {
    return HospitalModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      website: website ?? this.website,
      address: address ?? this.address,
      image: image ?? this.image,
      locationId: locationId ?? this.locationId,
      doctors: doctors ?? this.doctors,
      description: description ?? this.description,
    );
  }

  factory HospitalModel.empty() => HospitalModel(
    id: 0,
    name: '',
    phone: '',
    email: '',
    website: '',
    address: '',
    image: '',
    locationId: 0,
    doctors: [],
    description: '',
  );
}
