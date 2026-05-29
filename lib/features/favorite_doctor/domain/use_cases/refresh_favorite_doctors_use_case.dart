import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';

class RefreshFavoriteDoctorsUseCase {
  final DoctorRepo doctorRepo;

  RefreshFavoriteDoctorsUseCase(this.doctorRepo);

  Future<void> call() async {
    await doctorRepo.refreshFavoriteDoctors();
  }
}
