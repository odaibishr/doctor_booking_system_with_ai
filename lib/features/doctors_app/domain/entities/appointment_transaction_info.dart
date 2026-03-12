import 'package:hive_flutter/hive_flutter.dart';

part 'appointment_transaction_info.g.dart';

@HiveType(typeId: 17)
class AppointmentTransactionInfo {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final String status;

  AppointmentTransactionInfo({
    required this.id,
    required this.amount,
    required this.status,
  });
}
