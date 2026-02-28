// This class used to return current doctor's scheducles

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';

class GetMySchedulesUseCase extends Usecase<DoctorSchedule, NoParams> {
  final DoctorRepo doctorRepo;
  GetMySchedulesUseCase({required this.doctorRepo});
  @override
  Future<Either<Failure, DoctorSchedule>> call([NoParams? params]) {
    return doctorRepo.getMySchedules();
  }
}

class NoParams {}
