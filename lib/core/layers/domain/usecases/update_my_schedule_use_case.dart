// This class is used to update current doctor's schedule

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';

class UpdateMyScheduleUseCase
    extends Usecase<DoctorSchedule, Map<String, dynamic>> {
  final DoctorRepo doctorRepo;

  UpdateMyScheduleUseCase({required this.doctorRepo});

  @override
  Future<Either<Failure, DoctorSchedule>> call([
    Map<String, dynamic>? params,
    int? id,
  ]) async {
    return await doctorRepo.updateMySchedule(id!, params!);
  }
}
