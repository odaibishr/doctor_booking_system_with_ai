import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_profile_repo.dart';

class GetMyProfileUseCase {
  final DoctorProfileRepo repo;

  GetMyProfileUseCase(this.repo);

  Future<Either<Failure, Doctor>> call() {
    return repo.getMyProfile();
  }
}
