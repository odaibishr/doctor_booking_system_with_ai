class BookingTransaction {
  final int id;
  final int amount;
  final int paymentGatewayDetailId;
  final String createdAt;
  final String updatedAt;

  BookingTransaction({
    required this.id,
    required this.amount,
    required this.paymentGatewayDetailId,
    required this.createdAt,
    required this.updatedAt,
  });
}
