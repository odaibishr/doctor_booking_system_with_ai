import 'dart:convert';

import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking_transaction.dart';

class BookingTransactionModel extends BookingTransaction {
  BookingTransactionModel({
    required super.id,
    required super.amount,
    required super.paymentGatewayDetailId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory BookingTransactionModel.fromMap(Map<String, dynamic> data) =>
      BookingTransactionModel(
        id: data['id'] ?? 0,
        amount: (data['amount'] as num?)?.toInt() ?? 0,
        paymentGatewayDetailId: data['payment_gateway_detail_id'] ?? 0,
        createdAt: data['created_at'] ?? '',
        updatedAt: data['updated_at'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'amount': amount,
        'payment_gateway_detail_id': paymentGatewayDetailId,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  factory BookingTransactionModel.fromJson(String data) {
    return BookingTransactionModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  String toJson() => json.encode(toMap());

  BookingTransactionModel copyWith({
    int? id,
    int? amount,
    int? paymentGatewayDetailId,
    String? createdAt,
    String? updatedAt,
  }) {
    return BookingTransactionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      paymentGatewayDetailId:
          paymentGatewayDetailId ?? this.paymentGatewayDetailId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory BookingTransactionModel.empty() => BookingTransactionModel(
        id: 0,
        amount: 0,
        paymentGatewayDetailId: 0,
        createdAt: '',
        updatedAt: '',
      );
}
