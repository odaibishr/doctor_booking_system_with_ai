import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/repos/specialty_repo.dart';

class SpecialtyRepoImpl implements SpecialtyRepo {
  @override
  Future<Either<Failure, List<Specialty>>> getSpecialties() {
    // TODO: implement getSpecialties
    throw UnimplementedError();
  }
}