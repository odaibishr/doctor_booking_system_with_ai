import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/home/data/datasources/specilaty_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/repos/specialty_repo.dart';

class SpecialtyRepoImpl implements SpecialtyRepo {
  final SpecilatyRemoteDataSource remoteDataSource;

  SpecialtyRepoImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, List<Specialty>>> getSpecialties() async {
    try {
      log("Fetching specialties from remote data source");
      final result = await remoteDataSource.getSpecialties();

      log("Fetched ${result.length} specialties from remote data source");
      return Right(result);
    } catch (error) {
      log('Error fetching specialties: $error');
      return Left(Failure(error.toString()));
    }
  }
}
