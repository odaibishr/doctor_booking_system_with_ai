import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/hospital_repo.dart';

class HospitalRepoImpl implements HospitalRepo{
  @override
  Future<Either<Failure, List<Hospital>>> getHospitals() {
    // TODO: implement getHospitals
    throw UnimplementedError();
  }
}