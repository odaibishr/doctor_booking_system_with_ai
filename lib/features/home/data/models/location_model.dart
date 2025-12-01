import 'dart:convert';

import 'package:doctor_booking_system_with_ai/features/home/domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel({
    required super.id,
    required super.lat,
    required super.lng,
    required super.name,
  });

  factory LocationModel.fromMap(Map<String, dynamic> data) => LocationModel(
    id: data['id'] as int,
    lat: (data['lat'] as num).toDouble(),
    lng: (data['lng'] as num).toDouble(),
    name: data['name'] as String,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'lat': lat,
    'lng': lng,
    'name': name,
  };

  LocationModel copyWith({int? id, double? lat, double? lng, String? name}) {
    return LocationModel(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      name: name ?? this.name,
    );
  }

  factory LocationModel.fromJson(String data) {
    return LocationModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
