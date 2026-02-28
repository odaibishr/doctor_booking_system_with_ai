import 'package:doctor_booking_system_with_ai/core/utils/parse_helpers.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/earnings_data.dart';

class EarningsDataModel extends EarningsData {
  EarningsDataModel({
    required super.today,
    required super.week,
    required super.month,
    required super.all,
    required super.filtered,
  });
  factory EarningsDataModel.fromMap(Map<String, dynamic> map) {
    return EarningsDataModel(
      today: parseToDouble(map['today']),
      week: parseToDouble(map['week']),
      month: parseToDouble(map['month']),
      all: parseToDouble(map['all']),
      filtered: parseToDouble(map['filtered']),
    );
  }
}
