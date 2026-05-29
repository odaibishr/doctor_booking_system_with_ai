import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/specialty_repo.dart';

class RefreshAllSpecialtiesUseCase {
  final SpecialtyRepo specialtyRepo;

  RefreshAllSpecialtiesUseCase(this.specialtyRepo);

  Future<void> call() async {
    await specialtyRepo.refreshAllSpecialties();
  }
}
