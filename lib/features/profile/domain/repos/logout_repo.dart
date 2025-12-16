import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';

abstract class LogoutRepo {
  Future<Either<Failure, void>> logout();
} 