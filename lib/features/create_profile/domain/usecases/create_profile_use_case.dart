import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/domain/entities/profile.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/domain/repos/profile_repo.dart';

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
    );  
  }
}

class CreateProfileParams {
  final String phone;
  final String birthDate;
  final String gender;
  final int locationId;

  CreateProfileParams({
    required this.phone,
    required this.birthDate,
    required this.gender,
    required this.locationId,
  });
}
