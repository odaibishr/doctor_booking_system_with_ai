import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/profile.dart';

abstract class ProfileRepo {
  Future<Either<Failure, Profile>> createProfile({
    required String phone,
    required String birthDate,
    required String gender,
    required int locationId,
    required File? imageFile,
    String? name,
    String? email,
    String? password,
  });

  Future<Either<Failure, Profile>> getProfile();
}
