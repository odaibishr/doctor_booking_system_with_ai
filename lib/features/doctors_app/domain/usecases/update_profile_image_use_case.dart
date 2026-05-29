import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_profile_repo.dart';

class UpdateProfileImageUseCase {
  final DoctorProfileRepo repo;

  UpdateProfileImageUseCase(this.repo);

  Future<Either<Failure, String>> call(File imageFile) {
    return repo.updateProfileImage(imageFile);
  }
}
