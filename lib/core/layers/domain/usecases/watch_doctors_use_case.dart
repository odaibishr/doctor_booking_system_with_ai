import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';

class WatchDoctorsUseCase {
  final DoctorRepo doctorRepo;

  WatchDoctorsUseCase(this.doctorRepo);

  Stream<Either<Failure, List<Doctor>>> call() {
    return doctorRepo.watchDoctors();
  }
}
