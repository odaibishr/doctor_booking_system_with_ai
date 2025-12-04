import 'dart:convert';

import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';

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
    );
  }
}
