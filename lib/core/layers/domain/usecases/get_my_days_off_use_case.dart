// This class is used to return current doctor's days off

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';

class GetMyDaysOffUseCase
    extends Usecase<List<Map<String, dynamic>>, NoParams> {
  final DoctorRepo doctorRepo;

  GetMyDaysOffUseCase({required this.doctorRepo});

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> call([
    NoParams? params,
  ]) async {
    return await doctorRepo.getMyDaysOff();
  }
}

class NoParams {}
