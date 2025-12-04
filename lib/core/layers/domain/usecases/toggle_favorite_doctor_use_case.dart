import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';

class ToggleFavoriteDoctorUseCase
    extends Usecase<bool, ToggleFavoriteDoctorUseCaseParams> {
  final DoctorRepo doctorRepo;

  ToggleFavoriteDoctorUseCase(this.doctorRepo);

  @override
  Future<Either<Failure, bool>> call([
    ToggleFavoriteDoctorUseCaseParams? params,
  ]) async {
    await doctorRepo.toggleFavoriteDoctor(params!.doctorId);
  }
}

class ToggleFavoriteDoctorUseCaseParams {
  final int doctorId;
  ToggleFavoriteDoctorUseCaseParams(this.doctorId);
}
