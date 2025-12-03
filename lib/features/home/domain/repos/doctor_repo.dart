import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/doctor.dart';

abstract class DoctorRepo {
  Future<Either<Failure, List<Doctor>>> getDoctors();
  Future<Either<Failure, Doctor>> getDoctorDetails(int id);
}
