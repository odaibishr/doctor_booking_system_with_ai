// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';

class GetDoctorDetailsUseCase
    extends Usecase<Doctor, GetDoctorDetailsUseCaseParams> {
  final DoctorRepo doctorRepo;

  GetDoctorDetailsUseCase(this.doctorRepo);

  @override
  Future<Either<Failure, Doctor>> call([
    GetDoctorDetailsUseCaseParams? params,
  ]) async {
    return await doctorRepo.getDoctorDetails(params!.id);
  }
}

class GetDoctorDetailsUseCaseParams {
  final int id;
  GetDoctorDetailsUseCaseParams(this.id);
}
