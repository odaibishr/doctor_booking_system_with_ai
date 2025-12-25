import 'dart:convert';

import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel({
    required super.id,
    required super.lat,
    required super.lng,
    required super.name,
  });

  factory LocationModel.fromMap(Map<String, dynamic> data) {
    double parseDouble(dynamic value) {
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return LocationModel(
      id: data['id'] is int
          ? data['id'] as int
          : int.tryParse(data['id']?.toString() ?? '0') ?? 0,
      lat: parseDouble(data['lat'] ?? data['latitude']),
      lng: parseDouble(data['lng'] ?? data['longitude']),
      name: data['name']?.toString() ?? '',
    );
  }

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

  factory LocationModel.empty() =>
      LocationModel(id: 0, lat: 0.0, lng: 0.0, name: '');
}
