import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/profile_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/profile_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/profile.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/profile_repo.dart';
import 'package:doctor_booking_system_with_ai/core/network/network_info.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProfileRepoImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, Profile>> createProfile({
    required String phone,
    required String birthDate,
    required String gender,
    required int locationId,
    required File? imageFile,
    String? name,
    String? email,
    String? password,
  }) async {
    try {
      log(
        "Attempting to update/create profile with phone: $phone, birthDate: $birthDate, gender: $gender, locationId: $locationId, name: $name, email: $email",
      );
      if (!await networkInfo.isConnected) return Left(Failure('No internet'));
      final result = await remoteDataSource.createProfile(
        phone: phone,
        birthDate: birthDate,
        gender: gender,
        locationId: locationId,
        imageFile: imageFile,
        name: name,
        email: email,
        password: password,
      );
      await localDataSource.cachedProfile(result);
      log("Create profile result: ${result.phone}");
      return Right(result);
    } catch (error) {
      log("Create profile failed with error repo: $error");
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    try {
      if (!await networkInfo.isConnected) {
        final cachedProfile = await localDataSource.getCachedProfile();
        return Right(cachedProfile);
      }
      final result = await remoteDataSource.getProfile();
      await localDataSource.cachedProfile(result);
      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
