import 'package:hive_flutter/hive_flutter.dart';

part 'day.g.dart';

@HiveType(typeId: 10) // Unique typeId
class Day {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String dayName;
  @HiveField(2)
  final String shortName;
  @HiveField(3)
  final int dayNumber;

  Day({
    required this.id,
    required this.dayName,
    required this.shortName,
    required this.dayNumber,
  });
}
