// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/profile.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/profile_repo.dart';

class CreateProfileUseCase extends Usecase<Profile, CreateProfileParams> {
  final ProfileRepo _profileRepo;

  CreateProfileUseCase(this._profileRepo);
  @override
  Future<Either<Failure, Profile>> call([CreateProfileParams? params]) async {
    return await _profileRepo.createProfile(
      phone: params!.phone,
      birthDate: params.birthDate,
      gender: params.gender,
      locationId: params.locationId,
      imageFile: params.imageFile,
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class CreateProfileParams {
  final String phone;
  final String birthDate;
  final String gender;
  final int locationId;
  final File? imageFile;
  final String? name;
  final String? email;
  final String? password;

  CreateProfileParams({
    required this.phone,
    required this.birthDate,
    required this.gender,
    required this.locationId,
    this.imageFile,
    this.name,
    this.email,
    this.password,
  });
}
