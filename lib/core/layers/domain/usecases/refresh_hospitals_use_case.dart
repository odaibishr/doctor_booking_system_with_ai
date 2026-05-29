import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/hospital_repo.dart';

class RefreshHospitalsUseCase {
  final HospitalRepo hospitalRepo;

  RefreshHospitalsUseCase(this.hospitalRepo);

  Future<void> call() async {
    await hospitalRepo.refreshHospitals();
  }
}
