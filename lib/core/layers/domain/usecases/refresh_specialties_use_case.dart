import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/specialty_repo.dart';

class RefreshSpecialtiesUseCase {
  final SpecialtyRepo specialtyRepo;

  RefreshSpecialtiesUseCase(this.specialtyRepo);

  Future<void> call() async {
    await specialtyRepo.refreshSpecialties();
  }
}
