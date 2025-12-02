import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/repos/specialty_repo.dart';

class GetSpecilatiesUseCase extends Usecase<List<Specialty>, NoParams> {
  final SpecialtyRepo specialtyRepo;

  GetSpecilatiesUseCase(this.specialtyRepo);

  @override
  Future<Either<Failure, List<Specialty>>> call([NoParams? params]) async {
    return await specialtyRepo.getSpecialties();
  }
}

class NoParams {}
