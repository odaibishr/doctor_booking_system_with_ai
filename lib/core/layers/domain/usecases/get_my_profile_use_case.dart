// this class is used to get the current doctor's profile

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';

class GetMyProfileUseCase extends Usecase<Doctor, NoParams> {
  final DoctorRepo doctorRepo;

  GetMyProfileUseCase({required this.doctorRepo});

  @override
  Future<Either<Failure, Doctor>> call([NoParams? params]) async {
    return await doctorRepo.getMyProfile();
  }
}

class NoParams {}
