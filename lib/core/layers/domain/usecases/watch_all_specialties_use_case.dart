import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/specialty_repo.dart';

class WatchAllSpecialtiesUseCase {
  final SpecialtyRepo specialtyRepo;

  WatchAllSpecialtiesUseCase(this.specialtyRepo);

  Stream<Either<Failure, List<Specialty>>> call() {
    return specialtyRepo.watchAllSpecialties();
  }
}
