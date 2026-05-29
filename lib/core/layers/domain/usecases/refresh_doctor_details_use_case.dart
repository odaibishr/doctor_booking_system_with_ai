import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';

class RefreshDoctorDetailsUseCase {
  final DoctorRepo doctorRepo;

  RefreshDoctorDetailsUseCase(this.doctorRepo);

  Future<void> call(int id) async {
    await doctorRepo.refreshDoctorDetails(id);
  }
}
