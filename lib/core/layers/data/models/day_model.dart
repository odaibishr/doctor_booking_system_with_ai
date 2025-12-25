import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/day.dart';

class DayModel extends Day {
  DayModel({
    required super.id,
    required super.dayName,
    required super.shortName,
    required super.dayNumber,
  });

  factory DayModel.fromMap(Map<String, dynamic> map) {
    return DayModel(
      id: map['id'] ?? 0,
      dayName: map['day_name'] ?? '',
      shortName: map['short_name'] ?? '',
      dayNumber: map['day_number'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'day_name': dayName,
      'short_name': shortName,
      'day_number': dayNumber,
    };
  }
}
