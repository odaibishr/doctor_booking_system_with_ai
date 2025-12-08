import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';

class SearchDoctorsUseCase
    extends Usecase<List<Doctor>, SearchDoctorsUseCaseParams> {
  final DoctorRepo doctorRepo;

  SearchDoctorsUseCase(this.doctorRepo);

  @override
  Future<Either<Failure, List<Doctor>>> call([
    SearchDoctorsUseCaseParams? params,
  ]) async {
    return await doctorRepo.searchDoctors(params!.query);
  }
}

class SearchDoctorsUseCaseParams {
  final String query;
  SearchDoctorsUseCaseParams(this.query);
}
