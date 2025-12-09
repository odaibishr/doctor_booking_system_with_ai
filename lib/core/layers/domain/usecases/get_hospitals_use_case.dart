import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/hospital_repo.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';

class GetHospitalsUseCase extends Usecase<List<Hospital>, NoParams> {
  final HospitalRepo _hospitalRepo;

  GetHospitalsUseCase(this._hospitalRepo);

  @override
  Future<Either<Failure, List<Hospital>>> call([NoParams? params]) async {
    return await _hospitalRepo.getHospitals();
  }
}

class NoParams {}
