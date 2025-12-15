import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/profile.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/profile_repo.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';

class GetProfileUseCase extends Usecase<Profile, NoParams> {
  final ProfileRepo profileRepo;
  GetProfileUseCase(this.profileRepo);

  @override
  Future<Either<Failure, Profile>> call([NoParams? params]) async {
    return await profileRepo.getProfile();
  }
}

class NoParams {}
