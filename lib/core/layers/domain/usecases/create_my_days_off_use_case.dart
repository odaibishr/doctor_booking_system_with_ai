// This class is used to create current doctor days off

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';

class CreateMyDaysOffUseCase
    extends Usecase<List<Map<String, dynamic>>, List<int>> {
  final DoctorRepo doctorRepo;

  CreateMyDaysOffUseCase({required this.doctorRepo});

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> call([
    List<int>? params,
  ]) {
    return doctorRepo.createMyDaysOff(params!);
  }
}
