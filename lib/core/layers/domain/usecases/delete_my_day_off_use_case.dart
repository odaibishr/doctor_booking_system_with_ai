// This class is used to delete doctor's day off

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';

class DeleteMyDayOffUseCase extends Usecase<void, int> {
  final DoctorRepo doctorRepo;

  DeleteMyDayOffUseCase({required this.doctorRepo});

  @override
  Future<Either<Failure, void>> call([int? params]) {
    return doctorRepo.deleteMyDayOff(params!);
  }
}
