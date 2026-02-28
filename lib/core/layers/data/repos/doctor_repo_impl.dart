import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doctor_booking_system_with_ai/core/errors/exceptions.dart';
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

  static Failure _noDoctorsFailure() => Failure('عذراً، لا يوجد أطباء متاحون');

  static Failure _noDoctorDetailsFailure() =>
      Failure('عذراً، لا توجد بيانات لهذا الطبيب');

  @override
  Future<Either<Failure, List<Doctor>>> getDoctors() async {
    try {
      if (!await networkInfo.isConnected) {
        log('No internet connection');
        final cachedDoctors = await localDataSource.getCachedDoctors();
        if (cachedDoctors.isEmpty) return Left(_noDoctorsFailure());
        return Right(cachedDoctors);
      }

      final result = await remoteDataSource.getDoctors();
      if (result.isEmpty) return Left(_noDoctorsFailure());

      await localDataSource.cachedDoctors(result);
      log('Number of doctors fetched in RepoImpl: ${result.length}');
      return Right(result);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, Doctor>> getDoctorDetails(int id) async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedDoctors = await localDataSource.getCachedDoctors();
        if (cachedDoctors.isEmpty) return Left(_noDoctorDetailsFailure());
        return Right(cachedDoctors.firstWhere((element) => element.id == id));
      }

      final result = await remoteDataSource.getDoctorDetails(id);
      return Right(result);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, List<Doctor>>> searchDoctors(
    String query,
    int? specialtyId,
  ) async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedDoctors = await localDataSource.getCachedDoctors();
        if (cachedDoctors.isEmpty) return Left(_noDoctorsFailure());

        final foundDoctors = cachedDoctors
            .where(
              (element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()) &&
                  (specialtyId == null || element.specialtyId == specialtyId),
            )
            .toList();

        if (foundDoctors.isEmpty) return Left(_noDoctorsFailure());
        return Right(foundDoctors);
      }

      final result = await remoteDataSource.searchDoctors(query, specialtyId);
      if (result.isEmpty) return Left(_noDoctorsFailure());
      return Right(result);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavoriteDoctor(int doctorId) async {
    try {
      final result = await remoteDataSource.toggleFavoriteDoctor(doctorId);
      return Right(result);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<Either<Failure, List<Doctor>>> getFavoriteDoctors() async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedDoctors = await localDataSource.getCachedDoctors();
        final favoriteDoctors = cachedDoctors
            .where((doctor) => doctor.isFavorite == 1)
            .toList();
        if (favoriteDoctors.isEmpty) return Left(_noDoctorsFailure());
        return Right(favoriteDoctors);
      }

      final result = await remoteDataSource.getFavoriteDoctors();
      if (result.isEmpty) return Left(_noDoctorsFailure());
      return Right(result);
    } catch (e) {
      return _handleError(e);
    }
  }

  Either<Failure, T> _handleError<T>(dynamic e) {
    if (e is DioException) {
      try {
        handleDioException(e);
      } catch (e2) {
        if (e2 is ServerException) {
          return Left(Failure(e2.errorModel.errorMessage));
        }
        return Left(Failure(e2.toString()));
      }
    }
    if (e is ServerException) {
      return Left(Failure(e.errorModel.errorMessage));
    }
    return Left(Failure(e.toString()));
  }

  @override
  Future<Either<Failure, Doctor>> getMyProfile() async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(Failure('لا يوجد اتصال بالانترنت'));
      }
      final result = await remoteDataSource.getMyProfile();
      return Right(result);
    } catch (error) {
      return _handleError(error);
    }
  }
}
