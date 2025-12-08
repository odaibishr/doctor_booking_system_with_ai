import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';

abstract class HospitalRepo {
  Future<Either<Failure, List<Hospital>>> getHospitals();
}
