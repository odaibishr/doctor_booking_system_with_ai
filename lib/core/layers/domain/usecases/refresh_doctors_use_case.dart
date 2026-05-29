import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';

class RefreshDoctorsUseCase {
  final DoctorRepo doctorRepo;

  RefreshDoctorsUseCase(this.doctorRepo);

  Future<void> call() async {
    await doctorRepo.refreshDoctors();
  }
}
