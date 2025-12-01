import 'dart:convert';

class Hospital {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? website;
  String? address;
  String? image;
  int? locationId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Hospital({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.website,
    this.address,
    this.image,
    this.locationId,
    this.createdAt,
    this.updatedAt,
  });

  factory Hospital.fromMap(Map<String, dynamic> data) => Hospital(
    id: data['id'] as int?,
    name: data['name'] as String?,
    phone: data['phone'] as String?,
    email: data['email'] as String?,
    website: data['website'] as String?,
    address: data['address'] as String?,
    image: data['image'] as String?,
    locationId: data['location_id'] as int?,
    createdAt: data['created_at'] == null
        ? null
        : DateTime.parse(data['created_at'] as String),
    updatedAt: data['updated_at'] == null
        ? null
        : DateTime.parse(data['updated_at'] as String),
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
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Hospital].
  factory Hospital.fromJson(String data) {
    return Hospital.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Hospital] to a JSON string.
  String toJson() => json.encode(toMap());

  Hospital copyWith({
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
    return Hospital(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      website: website ?? this.website,
      address: address ?? this.address,
      image: image ?? this.image,
      locationId: locationId ?? this.locationId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
