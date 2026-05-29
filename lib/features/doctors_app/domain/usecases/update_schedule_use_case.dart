import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_profile_repo.dart';

class UpdateScheduleUseCase {
  final DoctorProfileRepo repo;

  UpdateScheduleUseCase(this.repo);

  Future<Either<Failure, DoctorSchedule>> call({
    required int id,
    required String startTime,
    required String endTime,
  }) {
    return repo.updateSchedule(id, startTime, endTime);
  }
}
