import 'dart:convert';

class Specialty {
  int? id;
  String? name;
  String? icon;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  Specialty({
    this.id,
    this.name,
    this.icon,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Specialty.fromMap(Map<String, dynamic> data) => Specialty(
    id: data['id'] as int?,
    name: data['name'] as String?,
    icon: data['icon'] as String?,
    isActive: data['is_active'] as bool?,
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
    'icon': icon,
    'is_active': isActive,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Specialty].
  factory Specialty.fromJson(String data) {
    return Specialty.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Specialty] to a JSON string.
  String toJson() => json.encode(toMap());

  Specialty copyWith({
    int? id,
    String? name,
    String? icon,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Specialty(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
