import 'package:hive_flutter/hive_flutter.dart';

part 'booking_transaction.g.dart';

@HiveType(typeId: 13)
class BookingTransaction {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int amount;
  @HiveField(2)
  final int paymentGatewayDetailId;
  @HiveField(3)
  final String createdAt;
  @HiveField(4)
  final String updatedAt;

  BookingTransaction({
    required this.id,
    required this.amount,
    required this.paymentGatewayDetailId,
    required this.createdAt,
    required this.updatedAt,
  });
}
