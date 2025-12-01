import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/home/data/datasources/doctor_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/repos/doctor_repo.dart';

class DoctorRepoImpl implements DoctorRepo {
  final DoctorRemoteDataSource remoteDataSource;

  DoctorRepoImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, List<Doctor>>> getDoctors() async {
    try {
      final result = await remoteDataSource.getDoctors();
      final doctors = <Doctor>[];

      if (result.isNotEmpty) {
        for (var doctor in result) {
          doctors.add(doctor);
        }
        log("Number of doctors fetched in RepoImpl: ${doctors.length}");
        return Right(doctors);
      }

      return Left(Failure('No doctors found'));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
