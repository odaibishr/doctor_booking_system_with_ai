import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_profile_repo.dart';

class DeleteDayOffUseCase {
  final DoctorProfileRepo repo;

  DeleteDayOffUseCase(this.repo);

  Future<Either<Failure, void>> call(int id) {
    return repo.deleteDayOff(id);
  }
}
