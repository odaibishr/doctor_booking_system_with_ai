import 'dart:convert';

import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';

class SpecialtyModel extends Specialty {
  SpecialtyModel({
    required super.id,
    required super.name,
    required super.icon,
    required super.isActive,
  });

  factory SpecialtyModel.fromMap(Map<String, dynamic> data) => SpecialtyModel(
    id:
        data['id'] is int
            ? data['id'] as int
            : int.tryParse('${data['id']}') ?? 0,
    name: (data['name'] ?? '').toString(),
    icon: (data['icon'] ?? '').toString(),
    isActive:
        data['is_active'] is bool
            ? data['is_active'] as bool
            : (data['is_active'] == 1 ||
                data['is_active'] == '1' ||
                '${data['is_active']}'.trim().toLowerCase() == 'true'),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'icon': icon,
    'is_active': isActive,
  };

  SpecialtyModel copyWith({
    int? id,
    String? name,
    String? icon,
    bool? isActive,
  }) {
    return SpecialtyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      isActive: isActive ?? this.isActive,
    );
  }

  factory SpecialtyModel.fromJson(String data) {
    return SpecialtyModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory SpecialtyModel.empty() =>
      SpecialtyModel(id: 0, name: '', icon: '', isActive: false);
}
