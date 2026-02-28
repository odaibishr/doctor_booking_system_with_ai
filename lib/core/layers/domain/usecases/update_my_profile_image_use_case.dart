// This class is used to update current doctor's image profile

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';

class UpdateMyProfileImageUseCase extends Usecase<String, File> {
  final DoctorRepo doctorRepo;

  UpdateMyProfileImageUseCase({required this.doctorRepo});

  @override
  Future<Either<Failure, String>> call([File? params]) async {
    return await doctorRepo.updateMyProfileImage(params!);
  }
}