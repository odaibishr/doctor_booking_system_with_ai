import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';

abstract class SpecialtyRepo {
  Future<Either<Failure, List<Specialty>>> getSpecialties();
  Future<Either<Failure, List<Specialty>>> getAllSpecialties();
  Stream<Either<Failure, List<Specialty>>> watchSpecialties();
  Future<Either<Failure, void>> refreshSpecialties();
  Stream<Either<Failure, List<Specialty>>> watchAllSpecialties();
  Future<Either<Failure, void>> refreshAllSpecialties();
}
