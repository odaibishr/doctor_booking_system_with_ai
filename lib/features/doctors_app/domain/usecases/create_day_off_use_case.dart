import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_day_off.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_profile_repo.dart';

class CreateDayOffUseCase {
  final DoctorProfileRepo repo;

  CreateDayOffUseCase(this.repo);

  Future<Either<Failure, List<DoctorDayOff>>> call(List<int> dayIds) {
    return repo.createDayOff(dayIds);
  }
}
