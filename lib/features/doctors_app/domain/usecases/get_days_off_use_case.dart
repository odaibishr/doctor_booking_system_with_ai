import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_day_off.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_profile_repo.dart';

class GetDaysOffUseCase {
  final DoctorProfileRepo repo;

  GetDaysOffUseCase(this.repo);

  Future<Either<Failure, List<DoctorDayOff>>> call() {
    return repo.getDaysOff();
  }
}
