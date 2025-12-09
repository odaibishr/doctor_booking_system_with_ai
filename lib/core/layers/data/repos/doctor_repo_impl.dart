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
      if (!await networkInfo.isConnected) {
        log('No internet connection');
        final cachedDoctors = await localDataSource.getCachedDoctors();
        if (cachedDoctors.isEmpty) {
          return Left(Failure('لم يتم العثور على أطباء'));
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

      return Left(Failure('لم يتم العثور على أطباء'));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, Doctor>> getDoctorDetails(int id) async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedDoctors = await localDataSource.getCachedDoctors();

        if (cachedDoctors.isEmpty) {
          return Left(Failure('لم يتم العثور على الطبيب'));
        }

        return Right(cachedDoctors.firstWhere((element) => element.id == id));
      }

      final result = await remoteDataSource.getDoctorDetails(id);

      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Doctor>>> searchDoctors(String query) async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedDoctors = await localDataSource.getCachedDoctors();

        if (cachedDoctors.isEmpty) {
          return Left(Failure('لم يتم العثور على أطباء'));
        }

        final foundDoctors = cachedDoctors
            .where(
              (element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

        return Right(foundDoctors);
      }

      final result = await remoteDataSource.searchDoctors(query);
      if (result.isEmpty) {
        return Left(Failure('لم يتم العثور على أطباء'));
      }
      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavoriteDoctor(int doctorId) async {
    try {
      final result = await remoteDataSource.toggleFavoriteDoctor(doctorId);
      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Doctor>>> getFavoriteDoctors() async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedDoctors = await localDataSource.getCachedDoctors();
        final favoriteDoctors =
            cachedDoctors.where((doctor) => doctor.isFavorite == 1).toList();

        return Right(favoriteDoctors);
      }

      final result = await remoteDataSource.getFavoriteDoctors();

      if (result.isEmpty) {
        return Left(Failure('لم يتم العثور على أطباء'));
      }

      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
