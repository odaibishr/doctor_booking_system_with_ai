import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_dashboard_repo.dart';

class RefreshDashboardStatsUseCase {
  final DoctorDashboardRepo doctorDashboardRepo;

  RefreshDashboardStatsUseCase(this.doctorDashboardRepo);

  Future<Either<Failure, void>> call(String filter) async {
    return await doctorDashboardRepo.refreshDashboardStats(filter);
  }
}
