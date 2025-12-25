import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';

abstract class PaymentRepo {
  Future<Either<Failure, String>> processPayment({
    required double amount,
    required String currency,
  });
}
