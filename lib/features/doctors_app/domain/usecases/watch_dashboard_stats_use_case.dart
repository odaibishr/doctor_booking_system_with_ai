import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/dashboard_stats.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_dashboard_repo.dart';

class WatchDashboardStatsUseCase {
  final DoctorDashboardRepo doctorDashboardRepo;

  WatchDashboardStatsUseCase(this.doctorDashboardRepo);

  Stream<Either<Failure, DashboardStats>> call(String filter) {
    return doctorDashboardRepo.watchDashboardStats(filter);
  }
}
