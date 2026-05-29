import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/hospital_repo.dart';

class WatchHospitalsUseCase {
  final HospitalRepo hospitalRepo;

  WatchHospitalsUseCase(this.hospitalRepo);

  Stream<Either<Failure, List<Hospital>>> call() {
    return hospitalRepo.watchHospitals();
  }
}
