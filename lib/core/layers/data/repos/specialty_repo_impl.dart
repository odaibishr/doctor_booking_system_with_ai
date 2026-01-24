import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/specialty_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/specilaty_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/specialty_repo.dart';

class SpecialtyRepoImpl implements SpecialtyRepo {
  final SpecilatyRemoteDataSource remoteDataSource;
  final SpecialtyLocalDataSource localDataSource;
  final NetworkInfo _networkInfo;

  SpecialtyRepoImpl(
    this.remoteDataSource,
    this.localDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, List<Specialty>>> getSpecialties() async {
    try {
      if (!await _networkInfo.isConnected) {
        final cachedSpecialties = await localDataSource.getSpecialties();
        return Right(cachedSpecialties);
      }

      log("Fetching active specialties from remote data source");

      final result = await remoteDataSource.getSpecialties();
      await localDataSource.cachedSpecialties(result);

      log(
        "Fetched ${result.length} active specialties from remote data source",
      );
      return Right(result);
    } catch (error) {
      log('Error fetching specialties: $error');
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Specialty>>> getAllSpecialties() async {
    try {
      if (!await _networkInfo.isConnected) {
        final cachedSpecialties = await localDataSource.getSpecialties();
        return Right(cachedSpecialties);
      }

      log("Fetching all specialties from remote data source");

      final result = await remoteDataSource.getAllSpecialties();

      log("Fetched ${result.length} specialties (all) from remote data source");
      return Right(result);
    } catch (error) {
      log('Error fetching all specialties: $error');
      return Left(Failure(error.toString()));
    }
  }
}
