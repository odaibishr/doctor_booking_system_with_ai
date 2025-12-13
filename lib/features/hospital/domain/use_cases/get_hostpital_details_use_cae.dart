import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/hospital_repo.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';

class GetHospitalDetailsUseCase
    extends Usecase<Hospital, GetHospitalDetailsParams> {
  final HospitalRepo hospitalRepo;
  GetHospitalDetailsUseCase(this.hospitalRepo);

  @override
  Future<Either<Failure, Hospital>> call([
    GetHospitalDetailsParams? params,
  ]) async {
    return await hospitalRepo.getHospitalDetailes(params!.id);
  }
}

class GetHospitalDetailsParams {
  final int id;

  GetHospitalDetailsParams(this.id);
}
