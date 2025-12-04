import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/doctor_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/doctor_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';

class DoctorRepoImpl implements DoctorRepo {
  final DoctorRemoteDataSource remoteDataSource;
  final DoctorLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DoctorRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Doctor>>> getDoctors() async {
    try {
      if (!await networkInfo.isConnected!) {
        log('No internet connection');
        final cachedDoctors = await localDataSource.getCachedDoctors();
        if (cachedDoctors.isEmpty) {
          return Left(Failure('No doctors found'));
        }
        return Right(cachedDoctors);
      }

      final result = await remoteDataSource.getDoctors();
      final doctors = <Doctor>[];

      if (result.isNotEmpty) {
        for (var doctor in result) {
          doctors.add(doctor);
        }

        await localDataSource.cachedDoctors(doctors);

        log("Number of doctors fetched in RepoImpl: ${doctors.length}");
        return Right(doctors);
      }

      return Left(Failure('No doctors found'));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, Doctor>> getDoctorDetails(int id) async {
    try {
      // get cached doctors and return the doctor with the given id
      if (!await networkInfo.isConnected!) {
        final cachedDoctors = await localDataSource.getCachedDoctors();

        if (cachedDoctors.isEmpty) {
          return Left(Failure('No doctors found'));
        }

        return Right(cachedDoctors.firstWhere((element) => element.id == id));
      }

      final result = await remoteDataSource.getDoctorDetails(id);

      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
