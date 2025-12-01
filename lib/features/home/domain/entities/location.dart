import 'dart:convert';

class Location {
  int? id;
  double? lat;
  double? lng;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  Location({
    this.id,
    this.lat,
    this.lng,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Location.fromMap(Map<String, dynamic> data) => Location(
    id: data['id'] as int?,
    lat: (data['lat'] as num?)?.toDouble(),
    lng: (data['lng'] as num?)?.toDouble(),
    name: data['name'] as String?,
    createdAt: data['created_at'] == null
        ? null
        : DateTime.parse(data['created_at'] as String),
    updatedAt: data['updated_at'] == null
        ? null
        : DateTime.parse(data['updated_at'] as String),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'lat': lat,
    'lng': lng,
    'name': name,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Location].
  factory Location.fromJson(String data) {
    return Location.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Location] to a JSON string.
  String toJson() => json.encode(toMap());

  Location copyWith({
    int? id,
    double? lat,
    double? lng,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Location(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
