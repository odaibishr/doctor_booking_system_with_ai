// This class is used to update the current doctor's profile

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';

class UpdateMyProfileUseCase extends Usecase<Doctor, Map<String, dynamic>> {
  final DoctorRepo doctorRepo;

  UpdateMyProfileUseCase({required this.doctorRepo});

  @override
  Future<Either<Failure, Doctor>> call([Map<String, dynamic>? params]) async {
    return await doctorRepo.updateMyProfile(params!);
  }
}
