import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/data/datasources/profile_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/domain/entities/profile.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/domain/repos/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Profile>> createProfile({
    required String phone,
    required String birthDate,
    required String gender,
    required int locationId,
  }) async {
    try {
      log("Attempting to create profile with phone: $phone");
      final result = await remoteDataSource.createProfile(
        phone: phone,
        birthDate: birthDate,
        gender: gender,
        locationId: locationId,
      );
      log("Create profile result: ${result.phone}");
      return Right(result);
    } catch (error) {
      log("Create profile failed with error: $error");
      return Left(Failure(error.toString()));
    }
  }
}
