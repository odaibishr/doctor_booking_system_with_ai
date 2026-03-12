
import 'package:hive_flutter/hive_flutter.dart';

part 'earnings_data.g.dart';

@HiveType(typeId: 14)
class EarningsData {
  @HiveField(0)
  final double today;
  @HiveField(1)
  final double week;
  @HiveField(2)
  final double month;
  @HiveField(3)
  final double all;
  @HiveField(4)
  final double filtered;

  EarningsData({
    required this.today,
    required this.week,
    required this.month,
    required this.all,
    required this.filtered,
  });
}
