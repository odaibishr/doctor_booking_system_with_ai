import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';

class WatchDoctorDetailsUseCase {
  final DoctorRepo doctorRepo;

  WatchDoctorDetailsUseCase(this.doctorRepo);

  Stream<Either<Failure, Doctor>> call(int id) {
    return doctorRepo.watchDoctorDetails(id);
  }
}
