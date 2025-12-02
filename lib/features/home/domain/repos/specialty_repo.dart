import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/specialty.dart';

abstract class SpecialtyRepo {
  Future<Either<Failure, List<Specialty>>> getSpecialties();
}