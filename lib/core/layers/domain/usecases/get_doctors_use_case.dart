import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';

class GetDoctorsUseCase extends Usecase<List<Doctor>, NoParams> {
  final DoctorRepo doctorRepo;
  GetDoctorsUseCase(this.doctorRepo);
  @override
  Future<Either<Failure, List<Doctor>>> call([NoParams? params]) async {
    return await doctorRepo.getDoctors();
  }
}

class NoParams {}
